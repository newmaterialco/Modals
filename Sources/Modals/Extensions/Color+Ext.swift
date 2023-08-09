//
//  Color+Ext.swift
//  Modals
//
//  Created by Samuel McGarry on 8/8/23.
//

import Foundation
import SwiftUI

public extension Color {
    static let systemBackground = Color(UIColor.systemBackground)
    
    static let modalBackground = Color(
        uiColor: UIColor(
            light: UIColor(hex: "#f7f7f7"),
            dark: UIColor(hex: "#141414")
        )
    )
}
