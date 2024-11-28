//
//  FilteringView.swift
//  ManageTask
//
//  Created by Sourav Santra on 16/11/24.
//

import SwiftUI

struct TaskDashboardFilteringView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var currentFilter: FilterOption?
    @State var locallySelectedFilter: FilterOption? = nil
    @State private var filterOptions: [FilterOption] = []
    
    var body: some View {
        NavigationStack {
            filteringOptionList
                .listStyle(.insetGrouped)
                .navigationTitle(TaskDashboardFilteringConstant.navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    cancelToolBarItem
                    
                    applyToolBarItem
                }
        }
        .onAppear {
            configureFilterOptionsAsPerCurrentFilter()
        }
    }
}

#Preview {
    TaskDashboardFilteringView(currentFilter: .constant(nil))
}


extension TaskDashboardFilteringView {
    
    private func configureFilterOptionsAsPerCurrentFilter() {
        if currentFilter != nil {
            locallySelectedFilter = currentFilter
            
            switch currentFilter!.type {
            case .dueDate:
                filterOptions =  [
                    .init(fromDate: currentFilter!.fromDate,
                          toDate: currentFilter!.toDate, type: .dueDate),
                    .init(type: .completionDate),
                    .init(type: .priority)
                ]
                
            case .completionDate:
                filterOptions = [
                    .init(type: .dueDate),
                    .init(fromDate: currentFilter!.fromDate,
                          toDate: currentFilter!.toDate, type: .completionDate),
                    .init(type: .priority)
                ]
                
            case .priority:
                filterOptions = [
                    .init(type: .dueDate),
                    .init(type: .completionDate),
                    .init(fromDate: Date(), toDate: Date(),
                          priority: currentFilter!.priority, type: .priority)
                ]
            }
        }
        else {
            filterOptions = [
                .init(type: .dueDate),
                .init(type: .completionDate),
                .init(type: .priority)
            ]
        }
    }
    
    private var filteringOptionList: some View {
        List {
            Section(TaskDashboardFilteringConstant.filterSectionTitle.uppercased()) {
                ForEach($filterOptions, id: \.type) { $option in
                    switch option.type {
                    case .dueDate, .completionDate:
                        FilteringListRowSelectionView(
                            title: option.type.rawValue,
                            filterOption: $option,
                            locallySelectedFilter: $locallySelectedFilter,
                            content: FilterListRowDateView(
                                fromDate: $option.fromDate, toDate: $option.toDate)
                        )
                        
                        
                    case .priority:
                        FilteringListRowSelectionView(
                            title: option.type.rawValue,
                            filterOption: $option,
                            locallySelectedFilter: $locallySelectedFilter,
                            content: FilterListRowPriorityView(priority: $option.priority)
                        )
                    }
                }
            }
        }
    }
    
    
    private var cancelToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarLeading) {
            Button(TaskDashboardFilteringConstant.ToolBarItemTitle.cancel) {
                dismiss()
            }
        }
    }
    
    private var applyToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button(TaskDashboardFilteringConstant.ToolBarItemTitle.apply) {
                if locallySelectedFilter != nil {
                    switch locallySelectedFilter!.type {
                    case .dueDate, .completionDate:
                        for option in filterOptions {
                            if option.type == locallySelectedFilter!.type {
                                locallySelectedFilter!.fromDate = option.fromDate
                                locallySelectedFilter!.toDate = option.toDate
                                break
                            }
                        }
                        
                    case .priority:
                        for option in filterOptions {
                            if option.type == locallySelectedFilter!.type {
                                locallySelectedFilter!.priority = option.priority
                                break
                            }
                        }
                    }
                    currentFilter = locallySelectedFilter
                }
                else {
                    currentFilter = nil
                }
                dismiss()
            }
        }
    }
}



