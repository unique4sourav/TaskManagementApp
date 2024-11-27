//
//  HomeViewModel.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import Foundation
import Combine
import SwiftUI


enum FilterType: String, CaseIterable, Identifiable {
    case dueDate = "Due Date"
    case completionDate = "Completion Date"
    case priority = "Priority"
    
    var id: Self { self }
}

struct FilterOption: Hashable {
    var fromDate = Calendar.current
        .date(byAdding: .weekOfYear, value: -1, to: Date()) ?? Date()
    var toDate = Date()
    var priority = PriorityOfTask.medium
    let type: FilterType
    
    init(fromDate: Date = Date(), toDate: Date = Date(), priority: PriorityOfTask = PriorityOfTask.medium, type: FilterType) {
        self.fromDate = fromDate
        self.toDate = toDate
        self.priority = priority
        self.type = type
    }
    
    init(type: FilterType) {
        self.type = type
    }
}



class HomeViewModel: ObservableObject {
    @Published private var allTasks: [TaskModel] = []
    @Published var selectedSortingOption: SortingOption = .nameAToZ
    @Published var selectedFilterOption: FilterOption? = nil
    @Published var selectedTaskCompletionStatus: TaskCompletionStatus = .all
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        //fetchAllTasks()
    }
    
    func addNew(task: TaskModel) {
        allTasks.append(task)
    }
    
    func getTasksAsPerCompletionStatus() -> [Binding<TaskModel>] {
        
        switch selectedTaskCompletionStatus {
        case .all:
            return allTasks.indices
                .filter(filterTaskIndicesByCompletionStatus)
                .filter(filterTaskIndicesBySelectedFilter)
                .sorted(by: sortBySelectedOption)
                .compactMap { [weak self] index in
                    guard let self else { return nil }
                    
                    return Binding(
                        get: { self.allTasks[index] },
                        set: { self.allTasks[index] = $0 }
                    )
                }
            
        case .overdue:
            return allTasks.indices
                .filter(filterTaskIndicesByCompletionStatus)
                .filter(filterTaskIndicesBySelectedFilter)
                .sorted(by: sortBySelectedOption)
                .compactMap { [weak self] index in
                    guard let self else { return nil }
                    
                    return Binding(
                        get: { self.allTasks[index] },
                        set: { self.allTasks[index] = $0 }
                    )}
            
        case .incomplete:
            return allTasks.indices
                .filter(filterTaskIndicesByCompletionStatus)
                .filter(filterTaskIndicesBySelectedFilter)
                .sorted(by: sortBySelectedOption)
                .compactMap { [weak self] index in
                    guard let self else { return nil }
                    
                    return Binding(
                        get: { self.allTasks[index] },
                        set: { self.allTasks[index] = $0 }
                    )}
            
        case .completed:
            return allTasks.indices
                .filter(filterTaskIndicesByCompletionStatus)
                .filter(filterTaskIndicesBySelectedFilter)
                .sorted(by: sortBySelectedOption)
                .compactMap { [weak self] index in
                    guard let self else { return nil }
                    
                    return Binding(
                        get: { self.allTasks[index] },
                        set: { self.allTasks[index] = $0 }
                    )}
        }
    }
    
    private func sortBySelectedOption(firstIndex: Int, secondIndex: Int) -> Bool {
        guard allTasks.count > firstIndex && allTasks.count > secondIndex
        else { return false }
        
        switch selectedSortingOption {
        case .nameAToZ:
            return allTasks[firstIndex].title < allTasks[secondIndex].title
        case .nameZToA:
            return allTasks[firstIndex].title > allTasks[secondIndex].title
        case .priorityLowToHigh:
            return allTasks[firstIndex].priority.rawValue < allTasks[secondIndex].priority.rawValue
        case .priorityHighToLow:
            return allTasks[firstIndex].priority.rawValue > allTasks[secondIndex].priority.rawValue
        case .dueDateAsAscending:
            return allTasks[firstIndex].dueDate < allTasks[secondIndex].dueDate
        case .dueDateAsDecending:
            return allTasks[firstIndex].dueDate > allTasks[secondIndex].dueDate
        }
    }
    
    private func filterTaskIndicesByCompletionStatus(index: Int) -> Bool {
        switch selectedTaskCompletionStatus {
        case .all:
            return true
            
        case .overdue:
            return allTasks[index].completionDate == nil &&
            allTasks[index].dueDate <= Date()
            
        case .incomplete:
            return allTasks[index].completionDate == nil &&
            allTasks[index].dueDate > Date()
            
        case .completed:
            return allTasks[index].completionDate != nil
        }
    }
    
    private func filterTaskIndicesBySelectedFilter(index: Int) -> Bool {
            if selectedFilterOption != nil {
                switch selectedFilterOption!.type {
                case .dueDate:
                    return (selectedFilterOption!.fromDate <= allTasks[index].dueDate) &&
                    (selectedFilterOption!.toDate >= allTasks[index].dueDate)
                    
                case .completionDate:
                    return allTasks[index].completionDate != nil &&
                    (selectedFilterOption!.fromDate <= allTasks[index].completionDate!) &&
                    (selectedFilterOption!.toDate >= allTasks[index].completionDate!)
                    
                case .priority:
                    return allTasks[index].priority == selectedFilterOption!.priority
                }
            }
            else {
                return true
            }
    }
}

extension HomeViewModel {
    func fetchAllTasks() {
        allTasks =
        [
            TaskModel(
                title: "Prepare Meeting Agenda",
                dueDate: Date().addingTimeInterval(-100066076),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Design App Wireframes",
                dueDate: Date().addingTimeInterval(-9696995),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            TaskModel(
                title: "Fix Login Bug",
                dueDate: Date().addingTimeInterval(-85969594),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            TaskModel(
                title: "Write Unit Tests",
                dueDate: Date().addingTimeInterval(-95549609),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Update API Documentation",
                dueDate: Date().addingTimeInterval(64899556),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            TaskModel(
                title: "Review Pull Requests",
                dueDate: Date().addingTimeInterval(7458948),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Research Market Trends",
                dueDate: Date().addingTimeInterval(3674859607),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Schedule Team Meeting",
                dueDate: Date().addingTimeInterval(478596699),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Create Marketing Plan",
                dueDate: Date().addingTimeInterval(-70695873),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            TaskModel(
                title: "Refactor Legacy Code",
                dueDate: Date().addingTimeInterval(3849505948),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            TaskModel(
                title: "Update User Guide",
                dueDate: Date().addingTimeInterval(69588596),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Conduct Code Review",
                dueDate: Date().addingTimeInterval(-34594859),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            TaskModel(
                title: "Optimize Database Queries",
                dueDate: Date(),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            TaskModel(
                title: "Test New Features",
                dueDate: Date().addingTimeInterval(-9596),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it.",
                completionDate: Date()),
            TaskModel(
                title: "Plan Sprint Backlog",
                dueDate: Date().addingTimeInterval(75007),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Write Blog Post",
                dueDate: Date().addingTimeInterval(-78594950),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Conduct User Testing",
                dueDate: Date().addingTimeInterval(-488538945),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Prepare Presentation",
                dueDate: Date().addingTimeInterval(8695506),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Analyze Analytics Data",
                dueDate: Date().addingTimeInterval(-97485604),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Organize Team Outing",
                dueDate: Date().addingTimeInterval(5367485),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Update Privacy Policy",
                dueDate: Date().addingTimeInterval(7485960594),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Debug API Issues",
                dueDate: Date().addingTimeInterval(-74895958),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Review Competitor Apps",
                dueDate: Date().addingTimeInterval(-4859658),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Develop Onboarding Flow",
                dueDate: Date().addingTimeInterval(4785958596),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Create Social Media Posts",
                dueDate: Date().addingTimeInterval(96076959),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Brainstorm App Features",
                dueDate: Date().addingTimeInterval(589609584),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Fix UI Overlaps",
                dueDate: Date().addingTimeInterval(475896584),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Schedule Maintenance Window",
                dueDate: Date().addingTimeInterval(7859606958),
                priority: .medium,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Prepare Deployment Plan",
                dueDate: Date().addingTimeInterval(74855960),
                priority: .high,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            TaskModel(
                title: "Conduct Security Audit",
                dueDate: Date().addingTimeInterval(-5896),
                priority: .low,
                notes: "Task Management App This app will help users manage their tasks effectively. Key Features: * Home Screen: Displays a list of tasks with options to filter by priorities or due dates. * Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. * Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it."),
            
        ]
    }
}


