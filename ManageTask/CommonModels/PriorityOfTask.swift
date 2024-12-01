//
//  PriorityOfTask.swift
//  ManageTask
//
//  Created by Sourav Santra on 01/12/24.
//

import Foundation

enum PriorityOfTask: Int, CaseIterable, Identifiable {
    case low, medium, high
    
    var description: String {
        "\(self)".capitalized
    }
    
    var id: Self { self }
}
