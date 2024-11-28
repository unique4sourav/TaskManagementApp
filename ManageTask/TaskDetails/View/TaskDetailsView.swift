//
//  TaskDetailsView.swift
//  ManageTask
//
//  Created by Sourav Santra on 28/11/24.
//

import SwiftUI

struct TaskDetailsView: View {
    let task: TaskModel
    
    @EnvironmentObject private var taskManager: TaskManager
    @StateObject private var viewModel = TaskDetailsViewModel()
    @State private var injectedPropertyDependency: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                titleAndDueDateView
                    .listRowSeparator(.visible)
                
                completionStatusView
                    .listRowSeparator(.visible)
                
                priorityView
                    .listRowSeparator(.visible)
                
                noteView
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .listRowSeparator(.visible)
            .navigationTitle(TaskDetailsConstant.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if task.isCompleted {
                    markIncompleteToolBarItem
                }
                else {
                    markCompleteToolBarItem
                }
            }
        }
    }
}


extension TaskDetailsView {
    private var titleView: some View {
        Text(task.title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(task.color)
    }
    
    private var dueDateView: some View {
        Text(task.dueDate.dateString)
            .foregroundStyle(.secondary)
    }
    
    private var titleAndDueDateView: some View {
        VStack(alignment: .leading) {
            titleView
            
            dueDateView
        }
    }
    
    
    private var completionStatusView: some View {
        HStack {
            Text(TaskDetailsConstant.FielTitle.completion)
                .font(.headline)
            
            Spacer()
            
            Text(task.completionStatus.rawValue)
                .foregroundStyle(viewModel.completionStatusColor(for: task))
        }
    }
    
    private var priorityView: some View {
        HStack {
            Text(TaskDetailsConstant.FielTitle.priority)
                .font(.headline)
            
            Spacer()
            
            Text(task.priority.description)
                .foregroundStyle(viewModel.priorityColor(for: task))
        }
    }
    
    private var noteView: some View {
        VStack(alignment: .leading) {
            Text(TaskDetailsConstant.FielTitle.note)
                .font(.headline)
            
            Text(task.note)
                .padding(.top, TaskDetailsConstant.Padding.betweenNoteFieldAndContent)
            
        }
    }
    
    private var markCompleteToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .bottomBar) {
            Button(TaskDetailsConstant.ToolBarItemTitle.markComplete) {
                viewModel.markComplete(task, using: taskManager)
            }
        }
    }
    
    private var markIncompleteToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .bottomBar) {
            Button(TaskDetailsConstant.ToolBarItemTitle.markIncomplete) {
                viewModel.markIncomplete(task, using: taskManager)
            }
            
        }
    }
    
}


#Preview {
    @Previewable @State var task = PreviewContent.shared.task
    TaskDetailsView(task: task)
        .environmentObject(TaskManager())
}
