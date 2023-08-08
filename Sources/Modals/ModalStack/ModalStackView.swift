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
            ModalRootContainerView<Content>(content: content)
            ModalSystemView()
        }
    }
}


struct ModalStackView_Previews: PreviewProvider {
    static var previews: some View {
        ModalStackView()
    }
}
