//
//  Modal.swift
//  FieldDay
//
//  Created by Samuel McGarry on 5/15/23.
//

import Foundation
import SwiftUI

public struct Modal: Identifiable, Hashable {
    public static func == (lhs: Modal, rhs: Modal) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public let id = UUID().uuidString
    @Binding var isPresented: Bool
    var size: ModalSize
    var cornerRadius: CGFloat
    var options: [ModalOption]
    var view: AnyView
    
    init(
        isPresented: Binding<Bool>,
        size: ModalSize,
        cornerRadius: CGFloat,
        options: [ModalOption],
        view: AnyView
    ) {
        self._isPresented = isPresented
        self.size = size
        self.cornerRadius = cornerRadius
        self.options = options
        self.view = view
    }
}

extension Modal {
    
    var isContentDraggable: Bool {
        for option in options {
            if option == .disableContentDragging {
                return false
            }
        }
        return true
    }
    
    var isHandleVisible: Bool {
        for option in options {
            if option == .prefersDragHandle {
                return true
            }
        }
        return false
    }
}
