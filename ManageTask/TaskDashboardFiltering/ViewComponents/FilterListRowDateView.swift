//
//  FilterListRowDateView.swift
//  ManageTask
//
//  Created by Sourav Santra on 28/11/24.
//

import SwiftUI

struct FilterListRowDateView: View {
    
    @Binding var fromDate: Date
    @Binding var toDate: Date
    
    var body: some View {
        VStack {
            DatePicker(
                TaskDashboardFilteringConstant.FieldTitle.dateFrom,
                selection: $fromDate, in: ...toDate)
            DatePicker(
                TaskDashboardFilteringConstant.FieldTitle.dateTo,
                selection: $toDate, in: fromDate...)
        }
    }
}

#Preview {
    FilterListRowDateView(fromDate: .constant(Date()), toDate: .constant(Date()))
}
