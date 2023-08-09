//
//  ModalSize.swift
//  FieldDay
//
//  Created by Samuel McGarry on 5/15/23.
//

import Foundation
import UIKit

public enum ModalSize {
    case small
    case medium
    case large
    case height(CGFloat)
    case fraction(CGFloat)
    
    var value: CGFloat {
        let screenHeight = UIApplication.shared.screenSize.height
        
        switch self {
        case .small:
            return screenHeight * 0.65
        case .medium:
            return screenHeight * 0.75
        case .large:
            return screenHeight * 0.9
        case .height(let height):
            return height
        case .fraction(let fraction):
            return screenHeight * fraction
        }
    }
}

extension UIApplication {
    public var screenSize: CGRect {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window?.screen.bounds ?? CGRect(x: 0, y: 0, width: 0, height: 0)
    }
}
