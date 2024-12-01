//
//  TaskCompletionStatus.swift
//  ManageTask
//
//  Created by Sourav Santra on 01/12/24.
//

import Foundation
import SwiftUICore

enum TaskCompletionStatus: LocalizedStringKey, CaseIterable, Identifiable {
    case all = "All"
    case overdue = "Overdue"
    case incomplete = "Incomplete"
    case completed = "Completed"
    
    var id: Self { self }
}
