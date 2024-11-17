//
//  HomeViewModel.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import Foundation
import Combine
import SwiftUI


class HomeViewModel: ObservableObject {
    @Published var allTasks: [Task] = []
    @Published var refinedTasks: [Task] = []
    @Published var selectedTaskCompletionStatus: TaskCompletionStatus = .all
    @Published var selectedSortingOption: SortingOption = .nameAToZ
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    
    private func addSubscribers() {
        $allTasks.combineLatest($selectedTaskCompletionStatus)
            .map(filterTasksByCompletion)
            .sink { [weak self] tasks in
                guard let self else {return }
                
                self.refinedTasks = tasks
            }
            .store(in: &cancellables)
    }
    
    
    
    private func filterTasksByCompletion(tasks allTasks: [Task], completionStatus: TaskCompletionStatus) -> [Task] {
        guard !allTasks.isEmpty
        else { return [] }
        
        switch completionStatus {
        case .all:
            //            print("number of all tasks before filtering: \(allTasks.count)")
            return allTasks
            
        case .overdue:
            //            print("number of overdue tasks before filtering: \(allTasks.count)")
            let overdueTasks = allTasks
                .filter { $0.completionDate == nil && $0.dueDate <= Date()}
            //            print("number of overdue tasks after filtering: \(overdueTasks.count)")
            return overdueTasks
            
        case .incomplete:
            //            print("number of incomplete tasks before filtering: \(allTasks.count)")
            let incompleteTasks = allTasks
                .filter { $0.completionDate == nil && $0.dueDate > Date()}
            //            print("number of incomplete tasks after filtering: \(incompleteTasks.count)")
            return incompleteTasks
            
        case .completed:
            //            print("number of completed tasks before filtering: \(allTasks.count)")
            let completedTasks = allTasks.filter { $0.completionDate != nil}
            //            print("number of completed tasks before filtering: \(completedTasks.count)")
            return completedTasks
        }
    }
    
    
    
    func sort(tasks: [Task], by sortingOption: SortingOption = .nameAToZ) -> [Task] {
        switch sortingOption {
        case .dueDateAsAscending:
            return tasks.sorted(by: { $0.dueDate < $1.dueDate })
            
        default:
            print("Default switch case.")
        }
        
        
        
        
        return []
    }
    
    
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
                completionDate: Date()),
            Task(
                title: "Complete the task management app. Complete the task management app.",
                dueDate: Date().addingTimeInterval(-969960606),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
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
