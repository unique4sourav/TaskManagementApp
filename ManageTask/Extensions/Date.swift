//
//  Date.swift
//  ManageTask
//
//  Created by Sourav Santra on 15/11/24.
//

import Foundation

extension Date {
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
    
    
}
