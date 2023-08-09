//
//  ModalStackView.swift
//  Modals
//
//  Created by Samuel McGarry on 8/8/23.
//

import SwiftUI

public struct ModalStackView<Content: View>: View {
    
    var content: () -> Content
    
    public var body: some View {
        ZStack {
            ModalStackContainerView<Content>(content: content)
            ModalSystemView()
        }
    }
}
