//
//  HomeViewModel.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import Foundation
import Combine
import SwiftUI
import Observation


enum FilterType: String, CaseIterable, Identifiable {
    case dueDate = "Due Date"
    case completionDate = "Completion Date"
    case priority = "Priority"
    
    var id: Self { self }
}

struct FilterOption: Hashable {
    var fromDate = Date().oneWeekEarlierOrCurrentIfFail
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


@Observable
final class TaskDashboardViewModel: ObservableObject {
    var selectedSortingOption: SortingOption = .nameAToZ
    var selectedFilterOption: FilterOption? = nil
    var selectedTaskCompletionStatus: TaskCompletionStatus = .all
    
    @ObservationIgnored private var cancellables = Set<AnyCancellable>()
    
    
    func getTasksAsPerCompletionStatus(using taskManager: TaskManagerProtocol) -> [any TaskModelProtocol] {
        return taskManager.allTasks.indices
            .filter{ filterTaskIndicesByCompletionStatus(index: $0, using: taskManager) }
            .filter{ filterTaskIndicesBySelectedFilter(index: $0, using: taskManager) }
            .sorted(by: { sortBySelectedOption(firstIndex: $0, secondIndex: $1, using: taskManager) })
            .compactMap({ taskManager.allTasks[$0] })
    }
    
    func toggleCompletion(of task: TaskModelProtocol, using taskManager: TaskManagerProtocol) {
        task.isCompleted ?
        taskManager.markIncomplete(task) :
        taskManager.markComplete(task)
    }
    
}

// MARK: - Internal functions
private extension TaskDashboardViewModel {
    func sortBySelectedOption(firstIndex: Int, secondIndex: Int, using taskManager: TaskManagerProtocol) -> Bool {
        guard taskManager.allTasks.count > firstIndex && taskManager.allTasks.count > secondIndex
        else { return false }
        
        switch selectedSortingOption {
        case .nameAToZ:
            return taskManager.allTasks[firstIndex].title <
                taskManager.allTasks[secondIndex].title
        case .nameZToA:
            return taskManager.allTasks[firstIndex].title >
            taskManager.allTasks[secondIndex].title
        case .priorityLowToHigh:
            return taskManager.allTasks[firstIndex].priority.rawValue <
                taskManager.allTasks[secondIndex].priority.rawValue
        case .priorityHighToLow:
            return taskManager.allTasks[firstIndex].priority.rawValue >
            taskManager.allTasks[secondIndex].priority.rawValue
        case .dueDateAsAscending:
            return taskManager.allTasks[firstIndex].dueDate <
                taskManager.allTasks[secondIndex].dueDate
        case .dueDateAsDecending:
            return taskManager.allTasks[firstIndex].dueDate >
            taskManager.allTasks[secondIndex].dueDate
        }
    }
    
    func filterTaskIndicesByCompletionStatus(index: Int, using taskManager: TaskManagerProtocol) -> Bool {
        switch selectedTaskCompletionStatus {
        case .all:
            return true
            
        case .overdue:
            return taskManager.allTasks[index].completionDate == nil &&
            taskManager.allTasks[index].dueDate <= Date()
            
        case .incomplete:
            return taskManager.allTasks[index].completionDate == nil &&
            taskManager.allTasks[index].dueDate > Date()
            
        case .completed:
            return taskManager.allTasks[index].completionDate != nil
        }
    }
    
    func filterTaskIndicesBySelectedFilter(index: Int, using taskManager: TaskManagerProtocol) -> Bool {
        if selectedFilterOption != nil {
            switch selectedFilterOption!.type {
            case .dueDate:
                return (selectedFilterOption!.fromDate <= taskManager.allTasks[index].dueDate) &&
                (selectedFilterOption!.toDate >= taskManager.allTasks[index].dueDate)
                
            case .completionDate:
                return taskManager.allTasks[index].completionDate != nil &&
                (selectedFilterOption!.fromDate <= taskManager.allTasks[index].completionDate!) &&
                (selectedFilterOption!.toDate >= taskManager.allTasks[index].completionDate!)
                
            case .priority:
                return taskManager.allTasks[index].priority == selectedFilterOption!.priority
            }
        }
        else {
            return true
        }
    }
}


