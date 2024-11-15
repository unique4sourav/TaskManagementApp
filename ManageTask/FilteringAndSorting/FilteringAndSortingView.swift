//
//  FilteringAndSortingView.swift
//  ManageTask
//
//  Created by Sourav Santra on 15/11/24.
//

import SwiftUI

struct FilteringAndSortingView: View {
    @Environment(\.dismiss) var dismiss
    @State var fromDate: Date = Date()
    @State var ToDate: Date = Date()
    
    
    
    var body: some View {
        NavigationStack {
            List {
                Section("Sort by:") {
                    Text("Name(A-Z)")
                    Text("Name(Z-A)")
                    Text("Priority(High-Low)")
                    Text("Priority(Low-High)")
                    Text("Date(Ascending)")
                    Text("Date(Decending)")
                }
                
                Section("Filter by:") {
                    Text("Due Date")
                    VStack {
                        DatePicker("From", selection: $fromDate, displayedComponents: .date)
                        DatePicker("To", selection: $fromDate, displayedComponents: .date)
                    }
                    
                    Text("Completion Date")
                    VStack {
                        DatePicker("From", selection: $fromDate, displayedComponents: .date)
                        DatePicker("To", selection: $fromDate, in: ...Date(), displayedComponents: .date)
                    }
                    
                    HStack {
                        Picker(selection: $fromDate) {
                            ForEach(TaskPriority.allCases) { priority in
                                Text(priority.description)
                            }
                        } label: {
                            Text("Priority")
                        }
                        
                        Text("Abcbjc")
                    }
                    
                }
                
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Sorting & Filtering")
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
    FilteringAndSortingView()
}
