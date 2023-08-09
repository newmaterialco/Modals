//
//  DismissModal.swift
//  FieldDay
//
//  Created by Samuel McGarry on 5/15/23.
//

import Foundation
import SwiftUI

public struct ModalSystemDismissAction {
    private var action: () -> Void
    
    func callAsFunction() {
        action()
    }
    
    init(action: @escaping () -> Void = { }) {
        self.action = action
    }
}

public struct ModalSystemDismissActionKey: EnvironmentKey {
    public static var defaultValue: ModalSystemDismissAction = ModalSystemDismissAction()
}

public extension EnvironmentValues {
    
    /// A closure that dismisses the top most presented modal when called.
    var dismissModal: ModalSystemDismissAction {
        get { self[ModalSystemDismissActionKey.self] }
        set { self[ModalSystemDismissActionKey.self] = newValue }
    }
}
