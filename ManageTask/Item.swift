//
//  Item.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
