//
//  FilteringView.swift
//  ManageTask
//
//  Created by Sourav Santra on 16/11/24.
//

import SwiftUI


extension Date {
    static var nilValue: Date? {
        return nil
    }
}


extension PriorityOfTask {
    static var nilValue: PriorityOfTask? {
        return nil
    }
}


enum FilteringOptionV2 {
    case dueDate(Date, Date)
    case completionDate(Date, Date)
    case priority(PriorityOfTask)
    
}


extension FilteringOptionV2: RawRepresentable, CaseIterable, Identifiable, Hashable {
    var id: UUID {
        UUID()
    }
    
    static var allCases: [FilteringOptionV2] = [
        FilteringOptionV2.dueDate(Date(timeIntervalSinceReferenceDate: 0), Date()),
        FilteringOptionV2.completionDate(Date(timeIntervalSinceReferenceDate: 0), Date()),
        FilteringOptionV2.priority(.medium)
    ]

    
    public init?(rawValue: String) {
        switch rawValue {
        case "Due Date":
            self = .dueDate(Date(timeIntervalSinceReferenceDate: 0), Date())
            
        case "Completion Date":
            self = .completionDate(Date(timeIntervalSinceReferenceDate: 0), Date())
            
        case "Priority":
            self = .priority(PriorityOfTask.medium)
            
        default:
            return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .dueDate:
            return "Due Date"
            
        case .completionDate:
            return "Completion Date"
            
        case .priority:
            return "Priority"
        }
    }

}


extension FilteringView {
    private var filteringOptionListV2: some View {
        VStack {
            List(selection: $selectedFilteringOptionV2) {
                Section("Filter by V2:".uppercased()) {
                    ForEach(FilteringOptionV2.allCases) { option in
                        switch option {
                        case .dueDate(var fromDate, var toDate):
                            VStack {
                                
                                DatePicker("From",
                                           selection: Binding<Date>(
                                            get: { fromDate },
                                            set: { fromDate = $0 } ),
                                           displayedComponents: .date)
                                
                                DatePicker("To",
                                           selection: Binding<Date>(
                                            get: { toDate },
                                            set: { toDate = $0 } ),
                                           displayedComponents: .date)
                            }
                            
                        default:
                            Text("")
                        }
                    }
                }
            }
            
            Spacer()
            
            Button("Print") {
                print("selectedFilteringOptionV2: \(String(describing: selectedFilteringOptionV2))")
            }
        }
    }
}


//extension FilteringOptionV2: RawRepresentable {
//    public init?(rawValue: String) {
//        switch rawValue {
//        case "Due Date":
//            self = .dueDate(nilDate, nilDate)
//            
//        case "Completion Date":
//            self = .completionDate(nilDate, nilDate)
//            
//        case "Priority":
//            self = .priority(nilPriority)
//            
//        default:
//            return nil
//        }
//    }
//    
//    public var rawValue: String {
//        switch self {
//        case .dueDate:
//            return "Due Date"
//            
//        case .completionDate:
//            return "Completion Date"
//            
//        case .priority:
//            return "Priority"
//        }
//    }
//}


























enum FilteringOption: String, CaseIterable, Identifiable {
    case dueDate = "Due Date"
    case completionDate = "Completion Date"
    case priority = "Priority"
    
    var id: Self { self }
}

struct FilteringView: View {
    @Environment(\.dismiss) var dismiss
    @State var fromDueDate: Date = Date(timeIntervalSinceReferenceDate: 0)
    @State var toDueDate: Date = Date()
    @State var fromCompletionDate: Date = Date(timeIntervalSinceReferenceDate: 0)
    @State var toCompletionDate: Date = Date()
    @State var selectedSortingOption: SortingOption?
    @State var selectedFilteringOption: FilteringOption?
    @State var selectedFilteringOptionV2: FilteringOptionV2? =
        .dueDate(Date(timeIntervalSinceReferenceDate: 0), Date())
    @State var selectedTaskPriority: PriorityOfTask = .medium
    @ObservedObject var viewModel: HomeViewModel
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                filteringOptionListV2
                
                filteringOptionList
                .listStyle(.insetGrouped)
                .navigationTitle("Filter Tasks")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    cancelToolBarItem
                    
                    applyToolBarItem
                }
            }
        }
    }
}

#Preview {
    FilteringView(viewModel: HomeViewModel())
}


extension FilteringView {
    private var filteringOptionList: some View {
        List(selection: $selectedFilteringOption) {
            Section("Filter by:".uppercased()) {
                ForEach(FilteringOption.allCases) { option in
                    switch option {
                    case .dueDate:
                        VStack {
                            CheckMarkRow(text: option.rawValue,
                                         isSelected: selectedFilteringOption == option)
                            DatePicker("From", selection: $fromDueDate, displayedComponents: .date)
                            DatePicker("To", selection: $toDueDate, displayedComponents: .date)
                        }
                        
                        
                    case .completionDate:
                        VStack {
                            CheckMarkRow(text: option.rawValue,
                                         isSelected: selectedFilteringOption == option)
                            DatePicker("From", selection: $fromCompletionDate, displayedComponents: .date)
                            DatePicker("To", selection: $toCompletionDate, displayedComponents: .date)
                        }
                        
                        
                    case .priority:
                        VStack {
                            CheckMarkRow(text: option.rawValue,
                                         isSelected: selectedFilteringOption == option)
                            Picker("", selection: $selectedTaskPriority) {
                                ForEach(PriorityOfTask.allCases, id: \.self) { priority in
                                    Text(priority.description)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                    }
                    
                }
            }
        }
    }
    
    
    private var cancelToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarLeading) {
            Button("Cancel") {
                dismiss()
            }
        }
    }
    
    private var applyToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Apply") {
                // TODO: Apply the filtering and sorting
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                    dismiss()
                })
            }
        }
    }
}
