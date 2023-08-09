//
//  ModalOption.swift
//  FieldDay
//
//  Created by Samuel McGarry on 5/22/23.
//

import Foundation

/// A series of options that can be passed into the .modal() modifier to adjust preferences for the modal stack.
public enum ModalOption {
    
    /// Replaces the default close button with a center-aligned drag handle.
    case prefersDragHandle
    
    /// Disables the ability to drag on content to dismiss the modal (sometimes useful when a ScrollView is embedded in the modal).
    case disableContentDragging
    
    /// Disables the scaling effect on the root content when a modal is presented.
    case disableBackgroundScaling
}
