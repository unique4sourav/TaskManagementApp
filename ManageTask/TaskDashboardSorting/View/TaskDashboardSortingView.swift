//
//  FilteringAndSortingView.swift
//  ManageTask
//
//  Created by Sourav Santra on 15/11/24.
//

import SwiftUI

enum SortingOption: String, CaseIterable, Identifiable {
    case nameAToZ = "Name(A-Z)"
    case nameZToA = "Name(Z-A)"
    case priorityLowToHigh = "Priority(Low-High)"
    case priorityHighToLow = "Priority(High-Low)"
    case dueDateAsAscending = "Due Date(Ascending)"
    case dueDateAsDecending = "Due Date(Decending)"
    var id: Self { self }
}


struct TaskDashboardSortingView: View {
    @Environment(\.dismiss) var dismiss
    @State var fromDate: Date = Date()
    @State var ToDate: Date = Date()
    @State var selectedSortingOption: SortingOption?
    @State var selectedTaskPriority: PriorityOfTask = .high
    @ObservedObject var viewModel: TaskDashboardViewModel
    
    init(viewModel: TaskDashboardViewModel) {
        self.viewModel = viewModel
        _selectedSortingOption = State(initialValue: viewModel.selectedSortingOption)
    }
    
    
    var body: some View {
        NavigationStack {
            sortingOptionList
            .listStyle(.insetGrouped)
            .navigationTitle("Sort Tasks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                cancelToolBarItem
                
                applyToolBarItem
            }
        }
    }
}

#Preview {
    TaskDashboardSortingView(viewModel: TaskDashboardViewModel())
}


extension TaskDashboardSortingView {
    private var sortingOptionList: some View {
        List(selection: $selectedSortingOption) {
            Section("Sort by:".uppercased()) {
                ForEach(SortingOption.allCases) { option in
                    CheckMarkRow(text: option.rawValue,
                                 isSelected: selectedSortingOption == option)
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
                if let selectedSortingOption {
                    viewModel.selectedSortingOption = selectedSortingOption
                    dismiss()
                }
            }
        }
    }
}
