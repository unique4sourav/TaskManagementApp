//
//  Color+Extension.swift
//  ManageTask
//
//  Created by Sourav Santra on 15/11/24.
//
import SwiftUI

extension Color {
    init?(_ taskColor: TaskColorString?) {
        switch taskColor?.rawValue {
        case "red": self = .red
        case "orange": self = .orange
        case "yellow": self = .yellow
        case "green": self = .green
        case "mint": self = .mint
        case "teal": self = .teal
        case "cyan": self = .cyan
        case "blue": self = .blue
        case "indigo": self = .indigo
        case "purple": self = .purple
        case "pink": self = .pink
        case "brown": self = .brown
        default: return nil
        }
    }
    
    init(rgbStruct rgb: RGB) {
      self.init(red: rgb.red, green: rgb.green, blue: rgb.blue)
    }

    static let customHighlight = Color("Highlight")
    static let customShadow = Color("Shadow")
}
