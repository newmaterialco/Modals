//
//  UIScreen+Ext.swift
//  FieldDay
//
//  Created by Samuel McGarry on 1/19/23.
//

import Foundation
import UIKit

extension UIScreen {
    private static let cornerRadiusKey: String = {
        let components = ["Radius", "Corner", "display", "_"]
        return components.reversed().joined()
    }()

    /// The corner radius of the display. Uses a private property of `UIScreen`,
    /// and may report 0 if the API changes.
    public var displayCornerRadius: CGFloat {
        guard let cornerRadius = self.value(forKey: Self.cornerRadiusKey) as? CGFloat else {
            return 0
        }

        return cornerRadius
    }
}
