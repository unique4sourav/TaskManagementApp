//
//  View+Extension.swift
//  ManageTask
//
//  Created by Sourav Santra on 15/11/24.
//

import Foundation
import SwiftUI

extension View {
    func northWestShadow(radius: CGFloat = 16, offset: CGFloat = 16) -> some View {
        return self
            .shadow(color: .customHighlight, radius: radius, x: -offset, y: -offset)
            .shadow(color: .customShadow, radius: radius, x: offset, y: offset)
    }
    
    func southEastShadow(radius: CGFloat = 16, offset: CGFloat = 6) -> some View {
        return self
          .shadow(
            color: .customShadow, radius: radius, x: -offset, y: -offset)
          .shadow(
            color: .customHighlight, radius: radius, x: offset, y: offset)
    }
}
