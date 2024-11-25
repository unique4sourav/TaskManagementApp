//
//  FilteringView.swift
//  ManageTask
//
//  Created by Sourav Santra on 16/11/24.
//

import SwiftUI

//enum FilteringOption: String, CaseIterable, Identifiable {
//    case dueDate = "Due Date"
//    case completionDate = "Completion Date"
//    case priority = "Priority"
//
//    var id: Self { self }
//}

struct FilteringView: View {
    @Environment(\.dismiss) var dismiss
    //@State var fromDueDate: Date = Date(timeIntervalSinceReferenceDate: 0)
    //@State var toDueDate: Date = Date()
    //@State var fromCompletionDate: Date = Date(timeIntervalSinceReferenceDate: 0)
    //@State var toCompletionDate: Date = Date()
    //@State var selectedSortingOption: SortingOption?
    //@State var selectedFilteringOption: FilteringOption?
    //@State var selectedTaskPriority: PriorityOfTask = .medium
    @ObservedObject var viewModel: HomeViewModel
    @State var locallySelectedFilter: FilterOption? = nil
    
    @State private var filterOptions: [FilterOption] = [
        .init(type: .dueDate),
        .init(type: .completionDate),
        .init(type: .priority)
    ]
    
    var body: some View {
        NavigationStack {
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

#Preview {
    FilteringView(viewModel: HomeViewModel())
}


extension FilteringView {
    private var filteringOptionList: some View {
        List {
            Section("Filter by:".uppercased()) {
                ForEach($filterOptions, id: \.type) { $option in
                    switch option.type {
                    case .dueDate, .completionDate:
                        FilteringListRowSelectionView(
                            title: option.type.rawValue,
                            filterOption: Binding(
                                get: { option },
                                set: { option = $0 }),
                            locallySelectedFilter: $locallySelectedFilter,
                            content: FilterListRowDateView(
                                fromDate: $option.fromDate, toDate: $option.toDate)
                        )
                        
                        
                    case .priority:
                        FilteringListRowSelectionView(
                            title: option.type.rawValue,
                            filterOption: Binding(
                                get: { option },
                                set: { option = $0 }),
                            locallySelectedFilter: $locallySelectedFilter,
                            content: Picker("", selection: $option.priority) {
                                ForEach(PriorityOfTask.allCases, id: \.self) { priority in
                                    Text(priority.description)
                                }
                            }.pickerStyle(.menu)
                        )
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
                print("Before applying filter")
                print("viewModel.selectedFilterOption: \(String(describing: viewModel.selectedFilterOption))")
                viewModel.selectedFilterOption = locallySelectedFilter
                print("Before applying filter")
                print("viewModel.selectedFilterOption: \(String(describing: viewModel.selectedFilterOption))")
            }
        }
    }
}



struct FilterListRowDateView: View {
    
    @Binding var fromDate: Date
    @Binding var toDate: Date
    
    var body: some View {
        VStack {
            DatePicker("From", selection: $fromDate, displayedComponents: .date)
            DatePicker("To", selection: $toDate, displayedComponents: .date)
        }
    }
}
