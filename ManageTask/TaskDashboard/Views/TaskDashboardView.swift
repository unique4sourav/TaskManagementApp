//
//  HomeView.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI

struct TaskDashboardView: View {
    @EnvironmentObject var taskManager: TaskManager
    @StateObject var viewModel = TaskDashboardViewModel()
    @State var shouldShowAddTaskView = false
    @State var shouldShowFilteringOptionView = false
    @State var shouldShowSortingOptionView = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                taskCompletionSegment
                
                taskList
                    .listStyle(.plain)
            }
            .navigationTitle(TaskDashboardConstant.navigationTitle)
            .toolbar {
                addTaskToolBarItem
                
                filteringToolBarItem
                
                sortingToolBarItem
                
            }
            
        }
    }
    
}

#Preview {
    TaskDashboardView()
        .environmentObject(TaskManager())
}


extension TaskDashboardView {
    private var taskCompletionSegment: some View {
        Picker("", selection: $viewModel.selectedTaskCompletionStatus) {
            ForEach(TaskCompletionStatus.allCases) { taskCompletionStatus in
                Text(taskCompletionStatus.rawValue)
            }
        }.pickerStyle(.segmented)
            .padding(.horizontal)
            .shadow(color: Color.shadow, radius: 10, x: 0, y: 0)
    }
    
    private var taskList: some View {
        List {
            ForEach(viewModel.getTasksAsPerCompletionStatus(using: taskManager))
            { task in
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
    }
    
    
    private var addTaskToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                shouldShowAddTaskView.toggle()
            } label: {
                Image(systemName: AppConstant.SFSymbolName.add)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .sheet(isPresented: $shouldShowAddTaskView) {
                AddTaskView()
            }
        }
    }
    
    private var filteringToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                shouldShowSortingOptionView.toggle()
            } label: {
                Image(systemName: viewModel.selectedFilterOption != nil ?
                      AppConstant.SFSymbolName.activeFilter :
                        AppConstant.SFSymbolName.inactiveFilter)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .sheet(isPresented: $shouldShowSortingOptionView) {
                TaskDashboardFilteringView(currentFilter: $viewModel.selectedFilterOption)
            }
        }
    }
    
    
    private var sortingToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                shouldShowFilteringOptionView.toggle()
            } label: {
                ZStack {
                    Image(systemName: AppConstant.SFSymbolName.sort)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .sheet(isPresented: $shouldShowFilteringOptionView) {
                TaskDashboardSortingView(currentSortingOption: $viewModel.selectedSortingOption)
            }
        }
    }
    
}
