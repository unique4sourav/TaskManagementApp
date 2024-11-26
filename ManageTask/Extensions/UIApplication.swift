//
//  UIApplication.swift
//  ManageTask
//
//  Created by Sourav Santra on 26/11/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
