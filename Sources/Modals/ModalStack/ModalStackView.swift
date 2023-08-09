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
    
    /// Sets the background color for the modal stack container.
    /// - Parameter color: The color to set
    func containerBackgroundColor(_ color: Color) -> ModalStackView {
        ModalSystem.shared.containerBackgroundColor = color
        return self
    }
    
    /// Sets the background color for the modal stack root content.
    /// - Parameter color: The color to set
    func contentBackgroundColor(_ color: Color) -> ModalStackView {
        ModalSystem.shared.contentBackgroundColor = color
        return self
    }
    
    /// Sets whether content scaling is enabled for the modal stack root content.
    /// - Parameter enabled: The boolean reflecting if scaling is enabled.
    func contentScaling(_ enabled: Bool) -> ModalStackView {
        ModalSystem.shared.isContentScalingEnabled = enabled
        return self
    }
    
    /// Sets whether content saturation is enabled for the modal stack root content.
    /// - Parameter enabled: The boolean reflecting if saturation is enabled.
    func contentSaturation(_ enabled: Bool) -> ModalStackView {
        ModalSystem.shared.isContentSaturationEnabled = enabled
        return self
    }
}


