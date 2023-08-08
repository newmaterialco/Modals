//
//  ModalSystemView.swift
//  FieldDay
//
//  Created by Samuel McGarry on 5/15/23.
//

import Foundation
import SwiftUI
import IdentifiedCollections
import Combine

struct ModalSystemView: View {
    @State var modals: IdentifiedArrayOf<Modal> = []

    var body: some View {
        ZStack {
            ForEach(Array(modals.enumerated()), id: \.element.id) { index, modal in
                ModalView(
                    modal: modal,
                    index: index,
                    isTopModal: index == modals.count - 1
                )
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onReceive(ModalSystem.shared.$modals, perform: { output in
            self.modals = output
        })
    }
}
