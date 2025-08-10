//
//  TryOnView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 26/07/2025.
//

import SwiftUI
struct TryOnView: View{
    @Environment(\.dismiss) var dismiss
    let rows = [GridItem(.fixed(100))]
    @State var showMenu = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var showImagePicker = false
    @State private var selectedImage: UIImage?
    @StateObject var myTattooViewModel: MyTattoosViewModel
    @StateObject var tryOnViewModel = TryOnViewModel()
    @State var selectedTryOnBodyIndex = 0
    @State var selectedTattooIndex = 0
    @State var alertType: AlertType?
    @State var mergedImage: UIImage?
    
    var body: some View{
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                
                VStack(spacing: AppSpacing.small){
                    
                    HStack(alignment: .center){
                        ScrollViewReader{ scrollProxy in
                            ScrollView(.horizontal, showsIndicators: false){
                                LazyHGrid(rows: rows, spacing: AppSpacing.medium){
                                    ForEach(Array(tryOnViewModel.tryOnList.enumerated()), id: \.offset){ index, image in
                                        
                                        Image(image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(AppRadius.medium)
                                            .onTapGesture {
                                                selectedTryOnBodyIndex = index
                                                self.selectedImage = nil
                                                
                                                withAnimation{
                                                    scrollProxy.scrollTo(index, anchor: .center)
                                                }
                                            }
                                            .overlay(RoundedRectangle(cornerRadius: AppRadius.medium)
                                                .stroke(selectedTryOnBodyIndex == index ? Color.orange : Color.clear, lineWidth: 2)
                                            )
                                    }
                                }
                            }
                        }
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 50, height: 50)
                            .cornerRadius(AppRadius.large)
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundStyle(.orange)
                            )
                            .onTapGesture {
                                showMenu = true
                            }
                    }
                    .frame(height: 100)
                    .frame( alignment: .top)
                    
                    TryOnCanvasView(selectedTryOnBodyIndex: selectedTryOnBodyIndex,
                                    tryOnViewModel: tryOnViewModel,
                                    selectedImage: self.selectedImage,
                                    myTattooViewModel: myTattooViewModel,
                                    selectedTattooIndex: selectedTattooIndex,
                                    onMergedImageUpdated: { mergedImage in
                        
                        self.mergedImage = mergedImage
                        
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                ScrollViewReader{ scrollProxy in
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHGrid(rows: rows, spacing: AppSpacing.medium){
                        ForEach(Array(myTattooViewModel.savedTattooURL.enumerated()), id: \.offset) {index, tattooUrl in
                            
                            if let tattooImage = ImageHelper.convertUrlToUIImage(url: tattooUrl.imageUrl){
                                
                                Image(uiImage:  tattooImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(AppRadius.medium)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: AppRadius.medium)
                                            .stroke(selectedTattooIndex == index ? Color.orange : Color.clear, lineWidth: 2)
                                    }
                                    .onTapGesture {
                                        selectedTattooIndex = index
                                        withAnimation{
                                            scrollProxy.scrollTo(index, anchor: .center)
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: 100)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
                
            }
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button(action: {
                        dismiss()
                    }){
                        Image(systemName: "chevron.left").backIconstyle()
                    }
                    
                    Text("tryon.title").titleTextStyle()
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        
                        if let mergedImage = self.mergedImage{
                            ImageHelper.saveImageToGallery(mergedImage, completion: { status in
                                if status{
                                    alertType = .success(message: NSLocalizedString("alert.tryon.success", comment: "Tattoo saved successfully"))
                                }else{
                                    alertType = .error(message: NSLocalizedString("alert.tryon.error", comment: "Error saving Tatoo"))
                                }
                            })
                        }else{
                            print("Error, merged image is not available")
                        }
                        
                    }){
                        Text("button.save")
                            .foregroundStyle(Colors.buttonBackgroundPrimaryColor)
                    }
                }
            }
            
            .navigationBarBackButtonHidden(true)
            .confirmationDialog("button.try_using", isPresented: $showMenu, titleVisibility: .visible){
                Button(action: {
                    sourceType = .camera
                    showImagePicker = true
                }){
                    Text("button.open_camera")
                }
                
                Button(action: {
                    sourceType = .photoLibrary
                    showImagePicker = true
                }){
                    Text("button.open_gallery")
                }
            }
            .task {
                do{
                    try await myTattooViewModel.getAllSavedTattooURL()
                    tryOnViewModel.getTryOnImages()
                }catch{
                    print("Error: \(error.localizedDescription)")
                }
            }
            
            .onChange(of: tryOnViewModel.tryOnList){ list in
                if list.count != 0 {
                    let imageString = list[selectedTryOnBodyIndex]
                    self.selectedImage = UIImage(named: imageString)
                }
            }
            
            .sheet(isPresented: $showImagePicker){
                ImagePicker(sourceType: sourceType, selectedImage: $selectedImage)
            }
            
            .alert(item: $alertType) { alert in
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.message),
                    dismissButton: .default(Text("OK")){
                        alertType = nil
                    }
                )
            }
        }
    }
}

#Preview {
    NavigationStack{
        let myTattooViewModel = DependencyContainer.shared.makeMyTattoosViewModel()
        TryOnView(myTattooViewModel: myTattooViewModel)
    }
}
