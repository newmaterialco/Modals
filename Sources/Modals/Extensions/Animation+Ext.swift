//
//  Animation+Ext.swift
//  FieldDay
//
//  Created by Vedant Gurav on 08/12/2022.
//

import SwiftUI

public extension Animation {
    static let stiffSpring = Animation.spring(response: 0.2, dampingFraction: 0.9)
    static let mediumSpring = Animation.spring(response: 0.25, dampingFraction: 0.8)
    static let softSpring = Animation.spring(response: 0.35, dampingFraction: 0.7)
    static let smoothSpring = Animation.spring(response: 0.55, dampingFraction: 0.82, blendDuration: 0.25)
}
