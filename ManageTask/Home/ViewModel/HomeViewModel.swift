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
    @Published var selectedSortingOption: SortingOption?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    
    private func addSubscribers() {
        $allTasks
            .combineLatest($selectedTaskCompletionStatus, $selectedSortingOption)
            .map(categoriseTasksByCompletionAndSort)
            .sink { [weak self] tasks in
                guard let self else {return }
                
                self.refinedTasks = tasks
            }
            .store(in: &cancellables)
    }
    
    private func categoriseTasksByCompletionAndSort(
        tasks allTasks: [Task], completionStatus: TaskCompletionStatus,
        sortingOption: SortingOption?) -> [Task] {
            let filteredTasksByCompletion = categoriseTasksByCompletion(tasks: allTasks, completionStatus: completionStatus)
            
            guard let sortingOption
            else { return filteredTasksByCompletion }
            
            switch sortingOption {
            case .nameAToZ:
                return filteredTasksByCompletion.sorted(by: { $0.title < $1.title })
                
            case .nameZToA:
                return filteredTasksByCompletion.sorted(by: { $0.title > $1.title })
                
            case .priorityLowToHigh:
                return filteredTasksByCompletion.sorted(by: { $0.priority.rawValue < $1.priority.rawValue })
                
            case .priorityHighToLow:
                return filteredTasksByCompletion.sorted(by: { $0.priority.rawValue > $1.priority.rawValue })
                
            case .dueDateAsAscending:
                return filteredTasksByCompletion.sorted(by: { $0.dueDate < $1.dueDate })
                
            case .dueDateAsDecending:
                return filteredTasksByCompletion.sorted(by: { $0.dueDate > $1.dueDate })
            }
        }
    
    private func categoriseTasksByCompletion(tasks allTasks: [Task], completionStatus: TaskCompletionStatus) -> [Task] {
        guard !allTasks.isEmpty
        else { return [] }
        
        switch completionStatus {
        case .all:
            return allTasks
            
        case .overdue:
            return allTasks.filter { $0.completionDate == nil && $0.dueDate <= Date()}
            
        case .incomplete:
            return allTasks.filter { $0.completionDate == nil && $0.dueDate > Date()}
            
        case .completed:
            return allTasks.filter { $0.completionDate != nil}
        }
    }
    
    func fetchAllTasks() {
        allTasks = [
            Task(
                title: "Prepare Meeting Agenda",
                dueDate: Date().addingTimeInterval(-100066076),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Design App Wireframes",
                dueDate: Date().addingTimeInterval(-9696995),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            Task(
                title: "Fix Login Bug",
                dueDate: Date().addingTimeInterval(-85969594),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            Task(
                title: "Write Unit Tests",
                dueDate: Date().addingTimeInterval(-95549609),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Update API Documentation",
                dueDate: Date().addingTimeInterval(64899556),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            Task(
                title: "Review Pull Requests",
                dueDate: Date().addingTimeInterval(7458948),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Research Market Trends",
                dueDate: Date().addingTimeInterval(3674859607),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Schedule Team Meeting",
                dueDate: Date().addingTimeInterval(478596699),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Create Marketing Plan",
                dueDate: Date().addingTimeInterval(-70695873),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            Task(
                title: "Refactor Legacy Code",
                dueDate: Date().addingTimeInterval(3849505948),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            Task(
                title: "Update User Guide",
                dueDate: Date().addingTimeInterval(69588596),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Conduct Code Review",
                dueDate: Date().addingTimeInterval(-34594859),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            Task(
                title: "Optimize Database Queries",
                dueDate: Date(),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            Task(
                title: "Test New Features",
                dueDate: Date().addingTimeInterval(-9596),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            Task(
                title: "Plan Sprint Backlog",
                dueDate: Date().addingTimeInterval(75007),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Write Blog Post",
                dueDate: Date().addingTimeInterval(-78594950),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Conduct User Testing",
                dueDate: Date().addingTimeInterval(-488538945),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Prepare Presentation",
                dueDate: Date().addingTimeInterval(8695506),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Analyze Analytics Data",
                dueDate: Date().addingTimeInterval(-97485604),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Organize Team Outing",
                dueDate: Date().addingTimeInterval(5367485),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Update Privacy Policy",
                dueDate: Date().addingTimeInterval(7485960594),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Debug API Issues",
                dueDate: Date().addingTimeInterval(-74895958),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Review Competitor Apps",
                dueDate: Date().addingTimeInterval(-4859658),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Develop Onboarding Flow",
                dueDate: Date().addingTimeInterval(4785958596),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Create Social Media Posts",
                dueDate: Date().addingTimeInterval(96076959),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Brainstorm App Features",
                dueDate: Date().addingTimeInterval(589609584),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Fix UI Overlaps",
                dueDate: Date().addingTimeInterval(475896584),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Schedule Maintenance Window",
                dueDate: Date().addingTimeInterval(7859606958),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Prepare Deployment Plan",
                dueDate: Date().addingTimeInterval(74855960),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            Task(
                title: "Conduct Security Audit",
                dueDate: Date().addingTimeInterval(-5896),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            
        ]
    }
}
