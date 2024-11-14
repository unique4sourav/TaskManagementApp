//
//  HomeViewModel.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import Foundation


class HomeViewModel: ObservableObject {
    @Published var allTasks: [Task] = []
    
    func fetchAllTasks() {
        allTasks = [
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(-1000660765),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(-969960606),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                isCompleted: true,
                completionDate: Date()),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(-969960606),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                isCompleted: true,
                completionDate: Date()),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(1000660765),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(1000660765),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                isCompleted: true,
                completionDate: Date()),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(1000660765),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(-969960606),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(1000660765),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(-969960606),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                isCompleted: true,
                completionDate: Date()),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(1000660765),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(1000660765),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(-1000660765),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                isCompleted: true,
                completionDate: Date()),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date(),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            
        ]
    }
}
