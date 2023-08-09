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
                            options: options,
                            view: AnyView(view())
                        )
                    )
                }
            }
    }
}

public extension View {
    func modal<V: View>(
        isPresented: Binding<Bool>,
        size: ModalSize = .large,
        cornerRadius: CGFloat = 36,
        options: [ModalOption] = [],
        _ view: @escaping () -> V
    ) -> some View {
        modifier(
            ModalSystemModifier(
                isPresented: isPresented,
                size: size,
                cornerRadius: cornerRadius,
                options: options,
                view: view
            )
        )
    }
}
