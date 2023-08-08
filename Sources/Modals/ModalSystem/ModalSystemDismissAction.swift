//
//  DismissModal.swift
//  FieldDay
//
//  Created by Samuel McGarry on 5/15/23.
//

import Foundation
import SwiftUI

struct ModalSystemDismissAction {
    private var action: () -> Void
    
    func callAsFunction() {
        action()
    }
    
    init(action: @escaping () -> Void = { }) {
        self.action = action
    }
}

struct ModalSystemDismissActionKey: EnvironmentKey {
    static var defaultValue: ModalSystemDismissAction = ModalSystemDismissAction()
}

extension EnvironmentValues {
    var dismissModal: ModalSystemDismissAction {
        get { self[ModalSystemDismissActionKey.self] }
        set { self[ModalSystemDismissActionKey.self] = newValue }
    }
}
