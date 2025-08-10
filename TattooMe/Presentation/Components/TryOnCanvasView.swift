//
//  TryOnCanvasView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 29/07/2025.
//
import SwiftUI
struct TryOnCanvasView: View{
    let selectedTryOnBodyIndex: Int
    let tryOnViewModel: TryOnViewModel
    let selectedImage: UIImage?
    let myTattooViewModel: MyTattoosViewModel
    let selectedTattooIndex: Int
    private let minTattooScale: CGFloat = 0.2
    var onMergedImageUpdated: ((UIImage?) -> Void)?
    
    @State private var tattooScale: CGFloat = 1.0
    @State private var tattooRotation: Angle = .zero
    @State private var tattooOffset: CGSize = .zero
    
    var body: some View{
        GeometryReader{ proxy in
            let screenWidth = proxy.size.width
            let bgImageSize = getBackgroundImageSize(forWidth: screenWidth)
            
            ZStack{
                if let selectedImage  = self.selectedImage{
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenWidth, height: bgImageSize.height)
                }else{
                    
                    if  selectedTryOnBodyIndex < tryOnViewModel.tryOnList.count{
                        
                        let imageString = tryOnViewModel.tryOnList[selectedTryOnBodyIndex]
                        
                        Image(imageString)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenWidth, height: bgImageSize.height)
                    }
                }
                
                let savedTattooCount = myTattooViewModel.savedTattooURL.count
                
                if selectedTattooIndex < savedTattooCount{
                    let selectedTattoo = ImageHelper.convertUrlToUIImage(url: myTattooViewModel.savedTattooURL[selectedTattooIndex].imageUrl)
                    
                    Image(uiImage: selectedTattoo!)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .transformable(scale: $tattooScale, rotation: $tattooRotation, offset: $tattooOffset)
                        .blendMode(.multiply)
                }
            }
            .frame(width: screenWidth, height: bgImageSize.height)
            .background(Color.white)
            .onChange(of: tattooScale) { newValue in
                let minTattooScale: CGFloat = 0.5
                if newValue < minTattooScale {
                    tattooScale = minTattooScale
                }
                updateMergedImage(width: screenWidth, height: bgImageSize.height)
            }
            
            .onChange(of: tattooRotation) { _ in updateMergedImage(width: screenWidth, height: bgImageSize.height) }
            .onChange(of: tattooOffset) { _ in updateMergedImage(width: screenWidth, height: bgImageSize.height) }
        }
    }
    
    private func updateMergedImage(width: CGFloat, height: CGFloat) {
           let renderer = ImageRenderer(content: renderedView(width: width, height: height))
           renderer.scale = UIScreen.main.scale
           DispatchQueue.main.async {
               onMergedImageUpdated?(renderer.uiImage)
           }
       }
    
    private func getBackgroundImageSize(forWidth width: CGFloat) -> CGSize {
          // Use actual image size if available, else default ratio 3:4
          if let selectedImage = selectedImage {
              let aspectRatio = selectedImage.size.height / selectedImage.size.width
              return CGSize(width: width, height: width * aspectRatio)
          }
          // Default fallback aspect ratio
          return CGSize(width: width, height: width * 4 / 3)
      }
}

extension TryOnCanvasView {
    @ViewBuilder
    func renderedView(width: CGFloat, height: CGFloat) -> some View {
        ZStack {
            if let selectedImage = self.selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                     .frame(width: width, height: height)
                
            } else if selectedTryOnBodyIndex < tryOnViewModel.tryOnList.count {
                let imageString = tryOnViewModel.tryOnList[selectedTryOnBodyIndex]
                Image(imageString)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
            }

            if selectedTattooIndex < myTattooViewModel.savedTattooURL.count {
                if let selectedTattoo = ImageHelper.convertUrlToUIImage(url: myTattooViewModel.savedTattooURL[selectedTattooIndex].imageUrl) {
                    Image(uiImage: selectedTattoo)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .scaleEffect(tattooScale)
                        .rotationEffect(tattooRotation)
                        .offset(tattooOffset)
                        .blendMode(.multiply)
                }
            }
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }
}

