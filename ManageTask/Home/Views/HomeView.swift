//
//  HomeView.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State var shouldShowAddNewTaskView = false
    @State var shouldShowFilteringOptionView = false
    @State var shouldShowSortingOptionView = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Task Completion Status",
                       selection: $viewModel.selectedTaskCompletionStatus) {
                    ForEach(TaskCompletionStatus.allCases) { taskCompletionStatus in
                        Text(taskCompletionStatus.rawValue)
                    }
                }.pickerStyle(.segmented)
                
                
                List {
                    ForEach($viewModel.refinedTasks) { task in
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
                }
                .listStyle(.plain)
                .onAppear {
                    if viewModel.refinedTasks.isEmpty {
                        viewModel.fetchAllTasks()
                    }
                }
            }
            .navigationTitle("All Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        shouldShowAddNewTaskView.toggle()
                    } label: {
                        Text("Add New")
                    }
                    .sheet(isPresented: $shouldShowAddNewTaskView) {
                        EmptyView()
                    }
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        shouldShowSortingOptionView.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    .sheet(isPresented: $shouldShowSortingOptionView) {
                        FilteringView(viewModel: viewModel)
                    }
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        shouldShowFilteringOptionView.toggle()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down.circle")
                    }
                    .sheet(isPresented: $shouldShowFilteringOptionView) {
                        SortingView(viewModel: viewModel)
                    }
                }
            }
            
        }
    }
    
}

#Preview {
    HomeView()
}
