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
    case priorityHighToLow = "Priority(High-Low)"
    case priorityLowToHigh = "Priority(Low-High)"
    case dateAsAscending = "Date(Ascending)"
    case dateAsDecending = "Date(Decending)"
    
    var id: Self { self }
}

struct FilteringAndSortingView: View {
    @Environment(\.dismiss) var dismiss
    @State var fromDate: Date = Date()
    @State var ToDate: Date = Date()
    @State var selectedSortingOption: SortingOption?
    
    
    var body: some View {
        NavigationStack {
            List(selection: $selectedSortingOption) {
                Section("Sort by:") {
                    ForEach(SortingOption.allCases) { option in
                        CheckMarkRow(text: option.rawValue, isSelected: selectedSortingOption == option)
                    }
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
