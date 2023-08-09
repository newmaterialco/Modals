//
//  ModalStackView.swift
//  Modals
//
//  Created by Samuel McGarry on 8/8/23.
//

import SwiftUI

/// The underlying view wrapper that handles presenting modals as global overlays
public struct ModalStackView<Content: View>: View {
    
    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            ModalStackContainerView<Content>(content: content)
            ModalSystemView()
        }
    }
}

public extension ModalStackView {
    
    /// Sets the background color for the modal stack container
    /// - Parameter color: The color to set
    func containerBackgroundColor(_ color: Color) -> ModalStackView {
        ModalSystem.shared.containerBackgroundColor = color
        return self
    }
    
    /// Sets the background color for the modal stack root content
    /// - Parameter color: The color to set
    func contentBackgroundColor(_ color: Color) -> ModalStackView {
        ModalSystem.shared.contentBackgroundColor = color
        return self
    }
}


