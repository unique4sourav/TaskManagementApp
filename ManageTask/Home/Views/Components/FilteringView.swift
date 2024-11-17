//
//  FilteringView.swift
//  ManageTask
//
//  Created by Sourav Santra on 16/11/24.
//

import SwiftUI

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
    @State var selectedTaskPriority: PriorityOfTask = .medium
    @ObservedObject var viewModel: HomeViewModel
    
    
    var body: some View {
        NavigationStack {
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
                                CheckMarkRow(text: option.rawValue, isSelected: selectedFilteringOption == option)
                                DatePicker("From", selection: $fromCompletionDate, displayedComponents: .date)
                                DatePicker("To", selection: $toCompletionDate, displayedComponents: .date)
                            }
                            
                            
                        case .priority:
                            VStack {
                                CheckMarkRow(text: option.rawValue, isSelected: selectedFilteringOption == option)
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
            .listStyle(.insetGrouped)
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                
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
    }
}
#Preview {
    FilteringView(viewModel: HomeViewModel())
}
