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
    
    @Published var bindingTasks: [Binding<TaskModel>] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService = TaskDataService()
    
    
    init() {
        addSubscribers()
    }
    
    
    func toggleCompleteness(for task: TaskModel) {
        print("toggleCompleteness(for task: TaskModel) is called.")
        let correspondingTask = bindingTasks.first { bindingTask in
            bindingTask.wrappedValue.id == task.id
        }
        if correspondingTask?.wrappedValue.completionDate == nil {
            correspondingTask?.wrappedValue.completionDate = Date()
        }
        else {
            correspondingTask?.wrappedValue.completionDate = nil
        }
        ObjectWillChangePublisher().send()
    }
    
    private func addSubscribers() {
        $selectedTaskCompletionStatus
            .sink { [weak self] taskCompletionStatus in
                guard let self else { return }
                
                switch taskCompletionStatus {
                case .all:
                    self.bindingTasks = self.dataService.allTasks
                    
                case .overdue:
                    self.bindingTasks = self.dataService.allTasks.filter { bindingTask in
                        bindingTask.completionDate.wrappedValue == nil &&
                        bindingTask.dueDate.wrappedValue < Date()
                    }
                    
                case .incomplete:
                    self.bindingTasks = self.dataService.allTasks.filter { bindingTask in
                        bindingTask.completionDate.wrappedValue == nil &&
                        bindingTask.dueDate.wrappedValue > Date()
                    }
                    
                case .completed:
                    self.bindingTasks = self.dataService.allTasks.filter { bindingTask in
                        bindingTask.completionDate.wrappedValue != nil
                    }
                }
            }
            .store(in: &cancellables)
        
        
        
//        $selectedTaskCompletionStatus
//            .combineLatest($bindingTasks)
//            .sink { [weak self] completionStatus, bindingTasks in
//                guard let self else { return }
//                
//                switch completionStatus {
//                case .all:
//                    self.bindingTasks = bindingTasks
//                    
//                case .overdue:
//                    self.bindingTasks = bindingTasks.filter { bindingTask in
//                        bindingTask.completionDate.wrappedValue == nil &&
//                        bindingTask.dueDate.wrappedValue < Date()
//                    }
//                    
//                case .incomplete:
//                    self.bindingTasks = bindingTasks.filter { bindingTask in
//                        bindingTask.completionDate.wrappedValue == nil &&
//                        bindingTask.dueDate.wrappedValue > Date()
//                    }
//                    
//                case .completed:
//                    self.bindingTasks = bindingTasks.filter { bindingTask in
//                        bindingTask.completionDate.wrappedValue != nil
//                    }
//                }
//            }
//            .store(in: &cancellables)
        
        
        
        
//        dataService.$allTasks
//            .combineLatest($selectedTaskCompletionStatus, $selectedSortingOption)
//            .map(categoriseTasksByCompletionAndSort)
//            .sink { [weak self] tasks in
//                guard let self else {return }
//                
//                self.refinedTasks = tasks
//            }
//            .store(in: &cancellables)
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
