//
//  FilteringListRow.swift
//  ManageTask
//
//  Created by Sourav Santra on 25/11/24.
//

import SwiftUI

struct FilteringListRow: View {
    let title: String
    @ObservedObject var viewModel: HomeViewModel
    @Binding var filterOption: FilteringOption
    
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            if viewModel.selectedFilterOption == filterOption {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
                    .foregroundStyle(.blue)
            }
        }
        .frame(height: 36)
        .contentShape(Rectangle())
        .onTapGesture {
            if viewModel.selectedFilterOption != nil {
                viewModel.selectedFilterOption = nil
            }
            else {
                viewModel.selectedFilterOption = filterOption
            }
        }
    }
}

#Preview {
    FilteringListRow(
        title: "Due Date",
        viewModel: HomeViewModel(),
        filterOption: .constant(.dueDate))
}
