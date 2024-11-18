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
    @Published var allTasks: [TaskModel] = []
    @Published var refinedTasks: [TaskModel] = []
    @Published var selectedTaskCompletionStatus: TaskCompletionStatus = .all
    @Published var selectedSortingOption: SortingOption = .nameAToZ
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService = TaskDataService()
    
    
    init() {
        addSubscribers()
    }
    
    
    private func addSubscribers() {
        dataService.$allTasks
            .combineLatest($selectedTaskCompletionStatus, $selectedSortingOption)
            .map(categoriseTasksByCompletionAndSort)
            .sink { [weak self] tasks in
                guard let self else {return }
                
                self.refinedTasks = tasks
            }
            .store(in: &cancellables)
    }
    
    private func categoriseTasksByCompletionAndSort(
        tasks allTasks: [TaskModel], completionStatus: TaskCompletionStatus,
        sortingOption: SortingOption?) -> [TaskModel] {
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
    
    private func categoriseTasksByCompletion(tasks allTasks: [TaskModel], completionStatus: TaskCompletionStatus) -> [TaskModel] {
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
    
}
