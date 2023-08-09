//
//  ModalSystem.swift
//  FieldDay
//
//  Created by Samuel McGarry on 2/3/23.
//
import Foundation
import SwiftUI
import IdentifiedCollections
import Combine

class ModalSystem {
    static let shared = ModalSystem()
    
    @Published var modals: IdentifiedArrayOf<Modal> = []
    @Published var dragProgress: CGFloat = 0
    
    var containerBackgroundColor: Color = Color.modalBackground
    var contentBackgroundColor: Color = Color.systemBackground
}

