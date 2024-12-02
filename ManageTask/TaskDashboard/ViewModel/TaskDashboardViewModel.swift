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
    
    
    func getTasksAsPerCompletionStatus(using taskManager: TaskManagerProtocol) -> [Binding<TaskModel>] {
        return taskManager.allTasks.indices
            .filter{ filterTaskIndicesByCompletionStatus(index: $0, using: taskManager) }
            .filter{ filterTaskIndicesBySelectedFilter(index: $0, using: taskManager) }
            .sorted(by: { sortBySelectedOption(firstIndex: $0, secondIndex: $1, using: taskManager) })
            .compactMap { index in
                return Binding(
                    get: { taskManager.allTasks[index] },
                    set: { taskManager.allTasks[index] = $0 }
                )
            }
    }
    
    private func sortBySelectedOption(firstIndex: Int, secondIndex: Int, using taskManager: TaskManagerProtocol) -> Bool {
        guard taskManager.allTasks.count > firstIndex && taskManager.allTasks.count > secondIndex
        else { return false }
        let firstTask = taskManager.allTasks[firstIndex]
        let secondTask = taskManager.allTasks[secondIndex]
        
        switch selectedSortingOption {
        case .nameAToZ:
            return firstTask.title < secondTask.title
        case .nameZToA:
            return firstTask.title > secondTask.title
        case .priorityLowToHigh:
            return firstTask.priority.rawValue < secondTask.priority.rawValue
        case .priorityHighToLow:
            return firstTask.priority.rawValue > secondTask.priority.rawValue
        case .dueDateAsAscending:
            return firstTask.dueDate < secondTask.dueDate
        case .dueDateAsDecending:
            return firstTask.dueDate > secondTask.dueDate
        }
    }
    
    private func filterTaskIndicesByCompletionStatus(index: Int, using taskManager: TaskManagerProtocol) -> Bool {
        let task = taskManager.allTasks[index]
        switch selectedTaskCompletionStatus {
        case .all:
            return true
            
        case .overdue:
            return task.completionDate == nil && task.dueDate <= Date()
            
        case .incomplete:
            return task.completionDate == nil && task.dueDate > Date()
            
        case .completed:
            return task.completionDate != nil
        }
    }
    
    private func filterTaskIndicesBySelectedFilter(index: Int, using taskManager: TaskManagerProtocol) -> Bool {
        if selectedFilterOption != nil {
            let task = taskManager.allTasks[index]
            switch selectedFilterOption!.type {
            case .dueDate:
                return (selectedFilterOption!.fromDate <= task.dueDate) &&
                (selectedFilterOption!.toDate >= task.dueDate)
                
            case .completionDate:
                return task.completionDate != nil &&
                (selectedFilterOption!.fromDate <= task.completionDate!) &&
                (selectedFilterOption!.toDate >= task.completionDate!)
                
            case .priority:
                return task.priority == selectedFilterOption!.priority
            }
        }
        else {
            return true
        }
    }
}


