//
//  ModalSystemModifier.swift
//  FieldDay
//
//  Created by Samuel McGarry on 5/15/23.
//

import Foundation
import SwiftUI

struct ModalSystemModifier<V: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    var size: ModalSize
    var cornerRadius: CGFloat
    var backgroundColor: Color
    var options: [ModalOption]
    var view: () -> V
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { newValue in
                if newValue {
                    ModalSystem.shared.modals.append(
                        Modal(
                            isPresented: $isPresented,
                            size: size,
                            cornerRadius: cornerRadius,
                            backgroundColor: backgroundColor,
                            options: options,
                            view: AnyView(view())
                        )
                    )
                }
            }
    }
}

public extension View {
    
    /// Creates and optionally presents a modal on top of the view hierarchy
    /// - Parameters:
    ///   - isPresented: A Binding Bool that sets the presentation of the modal.
    ///   - size: The size of the modal. The default value is `ModalSize.full`.
    ///   - cornerRadius: The corner radius of the modal. The default value is `36`.
    ///   - backgroundColor: The background color of the moda. The default is `Color.modalBackground`.
    ///   - options: An optional array of `ModalOption`'s that are applied to the modal.
    ///   - view: The content to be embedded in the modal.
    func modal<V: View>(
        isPresented: Binding<Bool>,
        size: ModalSize = .large,
        cornerRadius: CGFloat = 36,
        backgroundColor: Color = Color.modalBackground,
        options: [ModalOption] = [],
        _ view: @escaping () -> V
    ) -> some View {
        modifier(
            ModalSystemModifier(
                isPresented: isPresented,
                size: size,
                cornerRadius: cornerRadius,
                backgroundColor: backgroundColor,
                options: options,
                view: view
            )
        )
    }
}
