//
//  AppConstant.swift
//  ManageTask
//
//  Created by Sourav Santra on 29/11/24.
//

import Foundation
import SwiftUI

struct AppConstant {
    private init() {}
    
    static let defaultTaskColor: Color = .orange
    static let allTaskColors: [Color] = [
        .red, .orange, .green, .cyan, .blue,
        .indigo, .purple, .pink, .brown
    ]
    
    struct SFSymbolName {
        private init() {}
        
        static let cross = "xmark.circle"
        static let add = "plus.circle"
        static let inactiveFilter = "line.3.horizontal.decrease.circle"
        static let activeFilter = "line.3.horizontal.decrease.circle.fill"
        static let sort = "arrow.up.arrow.down.circle"
        static let checkmark = "checkmark"
        static let incompleteStateShownInCircle = "circle"
        static let completedStateShownInCircle = "checkmark.circle.fill"
        static let rightArrow = "chevron.right"
    }
    
}
