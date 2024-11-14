//
//  HomeView.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    func tasksWithStatus(_ completionStatus: TaskCompletionStatus) -> [Task] {
        switch completionStatus {
        case .overdue:
            return viewModel.allTasks.filter{ $0.isCompleted == false && $0.dueDate < Date()}
            
        case .incomplete:
            return viewModel.allTasks.filter{ $0.isCompleted == false && $0.dueDate > Date() }
            
        case .completed:
            return viewModel.allTasks.filter{ $0.isCompleted == true }
        }
        
    }
    
    // TODO: update incomplete and complete list on toggling completeness
    var body: some View {
        NavigationStack {
            List {
                ForEach(TaskCompletionStatus.allCases, id: \.hashValue) { completionStatus in
                    Section(completionStatus.rawValue) {
                        ForEach(tasksWithStatus(completionStatus)) { task in
                            ZStack(alignment: .leading) {
                                TaskView(task: task)
                                NavigationLink {
                                    EmptyView()
                                } label: {
                                    EmptyView()
                                }
                                .opacity(0)
                            }
                            .listRowSeparator(.hidden)
                        }
                        .listSectionSeparator(.visible)
                    }
                }
            }
            .listStyle(.plain)
            .onAppear {
                viewModel.fetchAllTasks()
            }
            .navigationTitle("All Tasks")
        }
    }
    
}

#Preview {
    HomeView()
}
