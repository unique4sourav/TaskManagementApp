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
    
    
    var body: some View {
        NavigationStack {
            List(selection: $selectedSortingOption) {
                Section("Sort by:".uppercased()) {
                    ForEach(SortingOption.allCases) { option in
                        CheckMarkRow(text: option.rawValue,
                                     isSelected: selectedSortingOption == option)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Sort")
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
    SortingView(viewModel: HomeViewModel())
}
