//
//  Color+Ext.swift
//  Modals
//
//  Created by Samuel McGarry on 8/8/23.
//

import Foundation
import SwiftUI

extension Color {
    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
    
    static let modalBackground = Color(
        uiColor: UIColor(
            light: UIColor(hex: "#f7f7f7"),
            dark: UIColor(hex: "#141414")
        )
    )
}
