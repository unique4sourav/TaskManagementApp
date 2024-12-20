//
//  HomeView.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI

struct TaskView: View {
    @Binding var task: TaskModel
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    taskTitle
                    otherTaskDetails
                }
                .foregroundStyle(.white)
                
                taskCompletionView
                rightArrow
            }
            .padding(.all, 16)
            .background(backgroundEffect)
            .padding(.horizontal, 0)
        }
    }
}

#Preview {
    let task = TaskModel(
        title: "Complete the task management app. Complete the task management app.",
        dueDate: Date(),
        priority: .high,
        notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.")
    
    TaskView(task: .constant(task))
}



extension TaskView {
    
    private var taskTitle: some View {
        HStack {
            Text(task.title)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)
            
            Spacer()
        }
    }
    
    private var otherTaskDetails: some View {
        HStack {
            Text(task.dueDate.dateString)
            Text("|")
            Text(task.priority.description)
        }
        .font(.subheadline)
    }
    
    private var taskCompletionView: some View {
        TaskCompletionIconView(
            for: task.completionDate != nil ?
                .completed : .incomplete,
            foregroundColor: .white)
        .frame(width: 20)
        .onTapGesture {
            task.toggleCompleteness()
        }
    }
    
    private var rightArrow: some View {
        Image(systemName: "chevron.right")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 8)
            .foregroundStyle(.white)
    }
    
    private var backgroundEffect: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(task.color ?? .secondary)
                .northWestShadow(radius: 3, offset: 1)
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 2)
                .fill(task.color ?? .secondary)
                .southEastShadow(radius: 1, offset: 1)
        }
    }
}
