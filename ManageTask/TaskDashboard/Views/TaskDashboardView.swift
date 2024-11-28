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
    @State var shouldShowAddNewTaskView = false
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
                addNewTaskToolBarItem
                
                filteringToolBarItem
                
                sortingToolBarItem
                
            }
            
        }
    }
    
}

#Preview {
    TaskDashboardView()
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
    
    
    private var addNewTaskToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                shouldShowAddNewTaskView.toggle()
            } label: {
                Image(systemName: TaskDashboardConstant.SFSymbolName.addNewTask)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .sheet(isPresented: $shouldShowAddNewTaskView) {
                AddNewTaskView()
            }
        }
    }
    
    private var filteringToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                shouldShowSortingOptionView.toggle()
            } label: {
                Image(systemName: viewModel.selectedFilterOption != nil ?
                      TaskDashboardConstant.SFSymbolName.activeFilter :
                        TaskDashboardConstant.SFSymbolName.inactiveFilter)
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
                    Image(systemName: TaskDashboardConstant.SFSymbolName.sort)
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
