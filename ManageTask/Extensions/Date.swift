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
    
    var adding30MinsOrCurrentIfFail: Date {
        Calendar.current.date(byAdding: .minute, value: 30, to: self) ?? self
    }
    
    var oneWeekEarlierOrCurrentIfFail: Date {
        Calendar.current.date(byAdding: .weekOfYear, value: -1, to: self) ?? self
    }
}
