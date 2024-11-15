//
//  HomeView.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(TaskCompletionStatus.allCases, id: \.hashValue) { completionStatus in
                    Section(completionStatus.rawValue) {
                        ForEach(viewModel.tasksWithStatus(completionStatus)) { task in
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
                if viewModel.allTasks.isEmpty {
                    viewModel.fetchAllTasks()
                }
            }
            .navigationTitle("All Tasks")
        }
    }
    
}

#Preview {
    HomeView()
}
