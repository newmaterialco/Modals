//
//  HighlightlessButtonStyle.swift
//  FieldDay
//
//  Created by Samuel McGarry on 12/20/22.
//

import Foundation
import SwiftUI

struct HighlightlessButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
