//
//  MyTattoosCardView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 03/07/2025.
//

import SwiftUI
struct MyTattoosCardView: View{
    var savedTattoImage: SavedTattooImage
    var body: some View {
           VStack {
               Rectangle()
                   .fill(Color.gray)
                   .frame(height: 200)
                   .overlay(
                    Group {
                          if let uiImage = ImageHelper.convertUrlToUIImage(url: savedTattoImage.imageUrl) {
                              Image(uiImage: uiImage)
                                  .resizable()
                                  .scaledToFill()
                          } else {
                              Image(systemName: "photo")
                                  .resizable()
                                  .scaledToFit()
                                  .foregroundColor(.white)
                                  .padding(AppSpacing.medium)
                          }
                      }
                   )
                   
           }
           .background(Color.black)
           .cornerRadius(AppRadius.medium)
           .shadow(radius: AppRadius.xsmall)
           .padding(5)
       }
}

#Preview {
    ZStack{
        Colors.primary.ignoresSafeArea()
        
        
        MyTattoosCardView(savedTattoImage: SavedTattooImage(imageUrl: URL(string: "hello")!))
    }
}
