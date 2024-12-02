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
    @State var locallySelectedSortingOption: SortingOption?
    @Binding var currentSortingOption: SortingOption
    
    var body: some View {
        NavigationStack {
            sortingOptionList
            .listStyle(.insetGrouped)
            .navigationTitle(TaskDashboardSortingConstant.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                cancelToolBarItem
                
                applyToolBarItem
            }
        }
        .onAppear {
            self.locallySelectedSortingOption = currentSortingOption
        }
    }
}

#Preview {
    TaskDashboardSortingView(currentSortingOption: .constant(.nameAToZ))
}


extension TaskDashboardSortingView {
    private var sortingOptionList: some View {
        List(selection: $locallySelectedSortingOption) {
            Section(TaskDashboardSortingConstant.sortSectionTitle.uppercased()) {
                ForEach(SortingOption.allCases) { option in
                    CheckMarkRow(text: option.rawValue,
                                 isSelected: locallySelectedSortingOption == option)
                }
            }
        }
    }
    
    private var cancelToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarLeading) {
            Button(TaskDashboardSortingConstant.ToolBarItemTitle.cancel) {
                dismiss()
            }
        }
    }
    
    private var applyToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button(TaskDashboardSortingConstant.ToolBarItemTitle.apply) {
                if let locallySelectedSortingOption {
                    currentSortingOption = locallySelectedSortingOption
                    dismiss()
                }
            }
        }
    }
}
