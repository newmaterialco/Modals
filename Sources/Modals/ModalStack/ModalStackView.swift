//
//  ModalStackView.swift
//  Modals
//
//  Created by Samuel McGarry on 8/8/23.
//

import SwiftUI

struct ModalStackView<Content: View>: View {
    
    var content: () -> Content
    
    var body: some View {
        ZStack {
            ModalStackContainerView<Content>(content: content)
            ModalSystemView()
        }
    }
}
