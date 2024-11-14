//
//  HomeView.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var completionStatus: [String] {
        Array(Set(viewModel.allTasks.map{ $0.isCompleted ? "Completed" : "Incomplete" }))
            .sorted(by: >)
    }
    
    func tasksWithStatus(_ completionStatus: String) -> [Task] {
        let filteredTasks = viewModel.allTasks.filter{ completionStatus == "Completed" ?
            $0.isCompleted : $0.isCompleted == false }
        return filteredTasks
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(completionStatus, id: \.hashValue) { completionStatus in
                    Section(completionStatus) {
                        ForEach(tasksWithStatus(completionStatus)) { task in
                            ZStack(alignment: .leading) {
                                TaskView(task: task)
//                                NavigationLink {
//                                    EmptyView()
//                                } label: {
//                                    EmptyView()
//                                }
//                                .opacity(0)
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
