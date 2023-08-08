//
//  ModalStackRootView.swift
//  Modals
//
//  Created by Samuel McGarry on 8/8/23.
//

import SwiftUI

struct ModalStackRootView<Content: View>: View, Equatable {
    static func == (lhs: ModalStackRootView, rhs: ModalStackRootView) -> Bool {
        true
    }
    
    var content: () -> Content
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            content()
        }
    }
}
