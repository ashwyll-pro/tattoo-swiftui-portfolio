//
//  Zoomable.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 29/07/2025.
//

import SwiftUI

struct Transformable: ViewModifier {
    @Binding var scale: CGFloat
    @Binding var rotation: Angle
    @Binding var offset: CGSize

    @GestureState private var gestureScale: CGFloat = 1.0
    @GestureState private var gestureRotation: Angle = .zero
    @GestureState private var gestureOffset: CGSize = .zero

    func body(content: Content) -> some View {
        let drag = DragGesture()
            .updating($gestureOffset) { value, state, _ in
                state = value.translation
            }
            .onEnded { value in
                offset.width += value.translation.width
                offset.height += value.translation.height
            }

        let zoom = MagnificationGesture()
            .updating($gestureScale) { value, state, _ in
                state = value
            }
            .onEnded { value in
                scale *= value
            }

        let rotate = RotationGesture()
            .updating($gestureRotation) { value, state, _ in
                state = value
            }
            .onEnded { value in
                rotation += value
            }

        let combined = SimultaneousGesture(SimultaneousGesture(drag, zoom), rotate)

        return content
            .scaleEffect(scale * gestureScale)
            .rotationEffect(rotation + gestureRotation)
            .offset(x: offset.width + gestureOffset.width,
                    y: offset.height + gestureOffset.height)
            .gesture(combined)
    }
}

extension View {
    func transformable(scale: Binding<CGFloat>, rotation: Binding<Angle>, offset: Binding<CGSize>) -> some View {
        self.modifier(Transformable(scale: scale, rotation: rotation, offset: offset))
    }
}


