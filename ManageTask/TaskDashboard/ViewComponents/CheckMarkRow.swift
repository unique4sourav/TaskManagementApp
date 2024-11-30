//
//  CheckMarkRow.swift
//  ManageTask
//
//  Created by Sourav Santra on 15/11/24.
//

import SwiftUI

struct CheckMarkRow: View {
    let text: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(text)
            
            Spacer()
            
            if isSelected {
                Image(systemName: AppConstant.SFSymbolName.checkmark)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
                    .foregroundStyle(.blue)
            }
        }
        .frame(height: 36)
    }
    
}

#Preview {
    CheckMarkRow(text: "Name(A-Z)", isSelected: false)
}
