//
//  FilteringView.swift
//  ManageTask
//
//  Created by Sourav Santra on 16/11/24.
//

import SwiftUI

struct FilteringView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HomeViewModel
    @State var locallySelectedFilter: FilterOption? = nil
    @State private var filterOptions: [FilterOption] = [
        .init(type: .dueDate),
        .init(type: .completionDate),
        .init(type: .priority)
    ]
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        _locallySelectedFilter = State(initialValue: viewModel.selectedFilterOption)
    }
    
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
                //                print("Before applying filter")
                //                print("viewModel.selectedFilterOption: \(String(describing: viewModel.selectedFilterOption))")
                //
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
                    viewModel.selectedFilterOption = locallySelectedFilter
                }
                else {
                    viewModel.selectedFilterOption = nil
                }
                
                //                print("Before applying filter")
                //                print("viewModel.selectedFilterOption: \(String(describing: viewModel.selectedFilterOption))")
                dismiss()
            }
        }
    }
}



struct FilterListRowDateView: View {
    
    @Binding var fromDate: Date
    @Binding var toDate: Date
    
    var body: some View {
        VStack {
            DatePicker("From", selection: $fromDate, in: ...toDate, displayedComponents: .date)
            DatePicker("To", selection: $toDate, in: fromDate..., displayedComponents: .date)
        }
    }
}
