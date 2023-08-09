//
//  ModalView.swift
//  FieldDay
//
//  Created by Samuel McGarry on 5/15/23.
//

import Foundation
import SwiftUI
import IdentifiedCollections

struct ModalView: View {
    @StateObject var keyboardObserver = KeyboardObserver()
    
    var index: Int
    var isTopModal: Bool
    var modal: Modal
    
    @GestureState private var isDragging: Bool
    @State private var containerOffset: CGFloat
    @State private var containerHeight: CGFloat
    @State private var contentOffset: CGFloat
    @State private var contentHeight: CGFloat
    @State private var isModalOverlayed: Bool = false
    
    @State var modalScale: CGFloat = 1.0
    @State var modalOffset: CGFloat = 0
    
    @State var dismissButtonScale: CGFloat = 1.0
    @State var dismissButtonOpacity: CGFloat = 1.0
    
    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let indicatorHeight: CGFloat = 26
    private let screenHeight: CGFloat
    private let defaultHeight: CGFloat
    private let defaultOffset: CGFloat
    private let defaultModalOffset: CGFloat
    
    init(modal: Modal, index: Int = -1, isTopModal: Bool) {
        self.index = index
        self.isTopModal = isTopModal
        self.modal = modal
        
        self.screenHeight = UIApplication.shared.screenSize.height
        self.defaultHeight = modal.size.value
        self.defaultOffset = screenHeight - modal.size.value
        
        let maxHeightDifference = ModalSize.large.value - ModalSize.small.value
        let heightDifference = (ModalSize.large.value - ModalSize.small.value) - (ModalSize.large.value - max(modal.size.value, ModalSize.small.value))
        let modalOffsetMultiplier = heightDifference == 0 ? 0 : heightDifference / maxHeightDifference
        let maxModalOffset: CGFloat = 14
        self.defaultModalOffset = maxModalOffset * modalOffsetMultiplier
        
        self._isDragging = GestureState(initialValue: false)
        self._containerOffset = State(initialValue: modal.size.value)
        self._containerHeight = State(initialValue: modal.size.value)
        self._contentOffset = State(initialValue: screenHeight)
        self._contentHeight = State(initialValue: modal.size.value - indicatorHeight)
    }
    
    var dragToCloseGesture: some Gesture {
        DragGesture(coordinateSpace: .named("ModalCoordinateSpace"))
            .updating($isDragging) { (value, gestureState, transaction) in
                gestureState = true
            }
            .onChanged { gesture in
                dragToCloseGestureDidChange(gesture.translation.height)
            }
    }
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color.black.opacity(0.00001)
                    .zIndex(0)
                    .onTapGesture {
                        close()
                    }
                ZStack(alignment: .bottom) {
                    modal.backgroundColor
                        .cornerRadius(modal.cornerRadius, corners: [.topLeft, .topRight])
                        .shadow(color: .black.opacity(0.12), radius: 24)
                        .frame(height: containerHeight)
                        .offset(y: containerOffset)
                        .zIndex(0)
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            visibilityIndicator
                            Spacer()
                        }
                        .background(Color.black.opacity(0.00001))
                        .simultaneousGesture(!keyboardObserver.isShowing ? dragToCloseGesture : nil)
                        .zIndex(20)
                        VStack {
                            modal.view
                                .frame(height: contentHeight)
                                .offset(y: -44)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.00001))
                        .simultaneousGesture(modal.isContentDraggable && !keyboardObserver.isShowing ? dragToCloseGesture : nil)
                    }
                    .cornerRadius(modal.cornerRadius)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .zIndex(10)
                    .offset(y: contentOffset)
                }
                .coordinateSpace(name: "ModalCoordinateSpace")
                .zIndex(1)
                .scaleEffect(x: modalScale, y: modalScale, anchor: .top)
                .offset(y: modalOffset)
                .onChange(of: containerOffset) { newValue in
                    let percentage = newValue / defaultHeight
                    ModalSystem.shared.dragProgress = percentage
                }
                .environment(\.dismissModal, ModalSystemDismissAction {
                    if isTopModal {
                        close()
                    }
                })
                .onChange(of: keyboardObserver.height) { newValue in
                    guard keyboardObserver.isShowing else { return }
                    guard index == ModalSystem.shared.modals.count - 1 else { return }
                    
                    let newHeight = newValue + 264
                    if newHeight > defaultHeight {
                        var transaction = Transaction()
                        transaction.isContinuous = true
                        transaction.animation = .interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)

                        withTransaction(transaction) {
                            containerHeight = newHeight
                            contentHeight = 264
                            contentOffset = screenHeight - newHeight
                        }
                    }
                }
                .onChange(of: keyboardObserver.isShowing) { newValue in
                    if !newValue {
                        var transaction = Transaction()
                        transaction.isContinuous = true
                        transaction.animation = .interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)
                        
                        withTransaction(transaction) {
                            containerHeight = defaultHeight
                            contentHeight = defaultHeight - indicatorHeight
                            contentOffset = screenHeight - defaultHeight
                        }
                    }
                }
                .onChange(of: isDragging) { newValue in
                    if !newValue {
                        dragToCloseGestureDidEnd(containerOffset)
                    }
                }
                .onAppear {
                    open()
                    self.keyboardObserver.addObserver()
                }
                .onDisappear {
                    self.keyboardObserver.removeObserver()
                }
                .onReceive(ModalSystem.shared.$modals, perform: { output in
                    self.isModalOverlayed = (output.count - 2 == index)
                })
                .onReceive(ModalSystem.shared.$dragProgress, perform: { output in
                    dragProgressDidChange(output)
                })
            }
        }
    }
    
    var visibilityIndicator: some View {
        Button(action: {
            close()
            self.selectionGenerator.selectionChanged()
        }) {
            if modal.isHandleVisible {
                HStack(spacing: -2) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray)
                        .frame(width: 24, height: 3)
                        .rotationEffect(Angle(degrees: isDragging ? 0 : 16), anchor: UnitPoint(x: 1, y: 0.5))
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray)
                        .frame(width: 24, height: 3)
                        .rotationEffect(Angle(degrees: isDragging ? 0 : -16), anchor: UnitPoint(x: 0, y: 0.5))
                }
                .frame(width: 80, height: 44)
                .background(Color.black.opacity(0.00001))
                .offset(x: 0, y: isDragging ? 0 : 4)
                .animation(.stiffSpring, value: isDragging)
                .opacity(dismissButtonOpacity)
                .scaleEffect(dismissButtonScale, anchor: .center)
            } else {
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 14))
                        .foregroundColor(.primary.opacity(0.5))
                        .frame(width: 40, height: 40)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .opacity(dismissButtonOpacity)
                        .scaleEffect(dismissButtonScale, anchor: .center)
                }
                .padding(.top, 30)
                .padding(.trailing, 8)
                .frame(height: 44)
            }
        }
        .buttonStyle(HighlightlessButtonStyle())
        .disabled(isDragging)
    }
    
    func dragProgressDidChange(_ newValue: CGFloat) {
        if isModalOverlayed {
            var transaction = Transaction()
            transaction.isContinuous = true
            transaction.animation = .interpolatingSpring(stiffness: 222, damping: 28)
            
            withTransaction(transaction) {
                modalOffset = (-defaultModalOffset) + abs(-defaultModalOffset) * newValue
                modalScale = 0.92 + 0.08 * newValue
                dismissButtonScale = 0.92 + (0.08 * newValue)
                dismissButtonOpacity = newValue
            }
        }
    }
    
    func dragToCloseGestureDidChange(_ newValue: CGFloat) {
        
        var transaction = Transaction()
        transaction.isContinuous = true
        transaction.animation = .interpolatingSpring(stiffness: 400, damping: 20)
        
        withTransaction(transaction) {
            if newValue < 0 {
                let percentageCompletion = abs(newValue) / defaultHeight / (screenHeight / 72)
                let multiplier = 1 + percentageCompletion.quarticEaseOut()
                let newHeight: CGFloat = defaultHeight * multiplier
                containerHeight = newHeight
                contentHeight = newHeight - indicatorHeight
                contentOffset = -(containerHeight - defaultHeight) + defaultOffset
            } else {
                contentOffset = newValue + defaultOffset
                containerOffset = newValue
            }
        }
    }
    
    func dragToCloseGestureDidEnd(_ newValue: CGFloat) {
        if newValue > (defaultHeight / 2) {
            close()
        } else {
            var transaction = Transaction()
            transaction.isContinuous = true
            transaction.animation = .interpolatingSpring(stiffness: 222, damping: 28)
            
            withTransaction(transaction) {
                contentOffset = defaultOffset
                contentHeight = defaultHeight - indicatorHeight
                containerOffset = 0
                containerHeight = defaultHeight
            }
        }
    }
    
    func open() {
        var transaction = Transaction()
        transaction.isContinuous = true
        transaction.animation = .interpolatingSpring(stiffness: 222, damping: 28)
        
        withTransaction(transaction) {
            contentOffset = defaultOffset
            containerOffset = 0
            containerHeight = defaultHeight
        }
    }
    
    func close() {
        var transaction = Transaction()
        transaction.isContinuous = true
        transaction.animation = .interpolatingSpring(stiffness: 222, damping: 28)
        
        withTransaction(transaction) {
            contentOffset = screenHeight
            contentHeight = defaultHeight - indicatorHeight
            containerOffset = defaultHeight
            containerHeight = defaultHeight
        }
        
        self.modal.isPresented = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ModalSystem.shared.modals.remove(id: self.modal.id)
        }
    }
}
