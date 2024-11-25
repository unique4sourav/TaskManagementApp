//
//  FilteringListRow.swift
//  ManageTask
//
//  Created by Sourav Santra on 25/11/24.
//

import SwiftUI

struct FilteringListRowSelectionView<Content: View>: View {
    let title: String
    @Binding var filterOption: FilterOption
    @Binding var locallySelectedFilter: FilterOption?
    
    let content: Content
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                
                Spacer()
                
                if locallySelectedFilter?.type == filterOption.type {
                    Image(systemName: "checkmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16)
                        .foregroundStyle(.blue)
                }
            }
            .frame(height: 36)
            
            content
        }
        
        .contentShape(Rectangle())
        .onTapGesture {
            print("Inside tap gesture before assinment")
            print("locallySelectedFilter = \(String(describing: locallySelectedFilter))")
            if locallySelectedFilter != nil,
               locallySelectedFilter!.type == filterOption.type {
                locallySelectedFilter = nil
            }
            else {
                locallySelectedFilter = filterOption
            }
            print("Inside tap gesture after assinment")
            print("locallySelectedFilter = \(String(describing: locallySelectedFilter))")
        }
    }
}

