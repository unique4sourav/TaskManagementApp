//
//  FilterListRowPriorityView.swift
//  ManageTask
//
//  Created by Sourav Santra on 28/11/24.
//

import SwiftUI

struct FilterListRowPriorityView: View {
    @Binding var priority: PriorityOfTask
    
    var body: some View {
        Picker("", selection: $priority) {
            ForEach(PriorityOfTask.allCases, id: \.self) { priority in
                Text(priority.description)
            }
        }.pickerStyle(.menu)
    }
}

#Preview {
    FilterListRowPriorityView(priority: .constant(.medium))
}
