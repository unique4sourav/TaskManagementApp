//
//  HomeView.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI


enum TaskColorString: String, CaseIterable {
    case red, orange, green, mint, teal, cyan, blue, indigo, purple, pink, brown
}

extension Color {
    init?(_ taskColor: TaskColorString?) {
        switch taskColor?.rawValue {
        case "red": self = .red
        case "orange": self = .orange
        case "yellow": self = .yellow
        case "green": self = .green
        case "mint": self = .mint
        case "teal": self = .teal
        case "cyan": self = .cyan
        case "blue": self = .blue
        case "indigo": self = .indigo
        case "purple": self = .purple
        case "pink": self = .pink
        case "brown": self = .brown
        default: return nil
        }
    }
}



struct TaskView: View {
    private let taskColor = Color(TaskColorString.allCases.randomElement())
    @Binding var task: Task
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(task.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    
                    HStack {
                        Text("15th Nov")
                        Text("|")
                        Text(task.priority.description)
                    }
                    .font(.subheadline)
                    
                }
                .foregroundStyle(.background)
                
                
                TaskCompletionIconView(
                    for: task.completionDate != nil ?
                        .completed : .incomplete,
                    foregroundColor: .white)
                .frame(width: 24)
                .onTapGesture {
                    task.toggleCompleteness()
                }
                
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 8)
                    .foregroundStyle(.white)
                
            }
            .padding(.all, 16)
            .background(
                taskColor ?? .secondary,
                in: RoundedRectangle(cornerRadius: 8)
            )
            .padding(.horizontal, 0)
            
        }
    }
}

#Preview {
    let task = Task(
        title: "Complete the task management app. Complete the task management app.",
        dueDate: Date(),
        priority: .high,
        notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.")
    
    TaskView(task: .constant(task))
}
