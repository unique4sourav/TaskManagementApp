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
            .navigationTitle("All Tasks")
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
        Picker("Task Completion Status",
               selection: $viewModel.selectedTaskCompletionStatus) {
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
                Image(systemName: "plus.circle")
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
                      "line.3.horizontal.decrease.circle.fill" :
                      "line.3.horizontal.decrease.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .sheet(isPresented: $shouldShowSortingOptionView) {
                TaskDashboardFilteringView(viewModel: viewModel)
            }
        }
    }
    
    
    private var sortingToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                shouldShowFilteringOptionView.toggle()
            } label: {
                ZStack {
                    Image(systemName: "arrow.up.arrow.down.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .sheet(isPresented: $shouldShowFilteringOptionView) {
                TaskDashboardSortingView(currentSortingOption: $viewModel.selectedSortingOption)
            }
        }
    }
    
    private var addNewTaskCustomButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.mint)
                .northWestShadow(radius: 3, offset: 3)
                .frame(width: 60, height: 60)
            
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 3)
                .fill(Color.mint)
                .southEastShadow(radius: 1, offset: 1)
                .frame(width: 60, height: 60)
            
            Image(systemName: "plus.circle")
                .resizable()
                .foregroundStyle(Color.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
            
        }
        .offset(x: -24, y: -24)
    }
}
