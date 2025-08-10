//
//  ToastModifier.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//

import SwiftUI
struct ToastModifier: ViewModifier{
    @Binding var isPresented: Bool
    let message: String
    let alignment: Alignment
}

extension ToastModifier{
    func body(content: Content) -> some View {
          ZStack {
              content

              if isPresented {
                  VStack {
                      ToastView(message: message, alignment: alignment)
                      Spacer()
                  }
                  .animation(.easeInOut, value: isPresented)
                  .onAppear {
                      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                          isPresented = false
                      }
                  }
              }
          }
      }
}

extension View {
    func toast(isPresented: Binding<Bool>, message: String, alignment: Alignment) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message, alignment: alignment))
    }
}
