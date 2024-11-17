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
    // TODO: think if we can add completion date as well
    var id: Self { self }
}


struct SortingView: View {
    @Environment(\.dismiss) var dismiss
    @State var fromDate: Date = Date()
    @State var ToDate: Date = Date()
    @State var selectedSortingOption: SortingOption?
    @State var selectedFilteringOption: FilteringOption?
    @State var selectedTaskPriority: PriorityOfTask = .high
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        let sortingOption = viewModel.selectedSortingOption
        //                print("viewModel.selectedSortingOption: \(viewModel.selectedSortingOption)")
        //                print("selectedSortingOption: \(sortingOption)")
        selectedSortingOption = sortingOption
        //                print("selectedSortingOption after assignment: \(selectedSortingOption)")
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
    SortingView(viewModel: HomeViewModel())
}


extension SortingView {
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
                print("Cancelled filtering.")
                dismiss()
            }
        }
    }
    
    private var applyToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Apply") {
                print("Sort tasks")
                viewModel.selectedSortingOption = selectedSortingOption
                //print("viewModel.selectedSortingOption: \(viewModel.selectedSortingOption)")
                dismiss()
            }
        }
    }
}
