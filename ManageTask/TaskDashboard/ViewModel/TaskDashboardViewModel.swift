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



final class TaskDashboardViewModel: ObservableObject {
    @Published var selectedSortingOption: SortingOption = .nameAToZ
    @Published var selectedFilterOption: FilterOption? = nil
    @Published var selectedTaskCompletionStatus: TaskCompletionStatus = .all
    private var cancellables = Set<AnyCancellable>()
    
    
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
    
    private func filterTaskIndicesByCompletionStatus(index: Int, using taskManager: TaskManagerProtocol) -> Bool {
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
    
    private func filterTaskIndicesBySelectedFilter(index: Int, using taskManager: TaskManagerProtocol) -> Bool {
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


