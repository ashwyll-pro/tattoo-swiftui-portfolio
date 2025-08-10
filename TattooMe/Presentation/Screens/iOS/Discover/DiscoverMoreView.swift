//
//  DiscoverMoreView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//
import SwiftUI
struct DiscoverMoreView: View{
    @Environment(\.dismiss) var dismiss
    @StateObject var discoverViewModel: DiscoverViewModel
    var tattooStyleID: String
    @State var selectedDiscoverItem: DiscoverItem?
    @State var isDiscoverItemSelected = false
    @State private var showError = false
    @State private var downloadedTattoo: UIImage?
    @State var alertType: AlertType?
    @StateObject var photoLibraryPermissionManager = PhotoLibraryPermissionManager()
    @StateObject var premiumSubscriptionViewModel = PremiumSubscriptionViewModel()
    @State var isSavingTattoo: Bool = false
    @State var openTryOn = false
    @State var downloadComplete = false
    @State var isProActive = false
    @StateObject var interstititalModel = InterstitialViewModel()
    
    var tattooPromptClosure: (String) -> Void?
   
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View{
        ZStack{
            Color.black.ignoresSafeArea()
            
            if discoverViewModel.isLoading{
                VStack{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    Text("alert.loading.message")
                        .bodyTextStyle()
                }
            }else{
                sectionView
                
                if isSavingTattoo {
                    DownloadingView(message: NSLocalizedString("discover.downloading", comment: "downloading tattoo"))
                        .zIndex(1)
                        .animation(.easeInOut, value: isSavingTattoo)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItemGroup(placement: .topBarLeading){
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "chevron.left")
                        .backIconstyle()
                    Text(NSLocalizedString("tattoo_style.\(tattooStyleID).name", comment: ""))
                        .titleTextStyle()
                }
            }
        }
        .task {
             await discoverViewModel.getTattoosDiscoverByTattooStyleID(tattooStyleID: tattooStyleID)
            await premiumSubscriptionViewModel.checkSubscriptionStatus()
            await interstititalModel.loadAd()
        }
        
        .onChange(of: discoverViewModel.errorMessage) { newValue in
            if !newValue.isEmpty {
                    alertType = .error(message: newValue)
                    discoverViewModel.errorMessage = ""
                }
        }
        
        .onChange(of: interstititalModel.adDismissed) { dismissed in
            guard dismissed else { return }
            
            openTryOn = true
            downloadComplete = false
            interstititalModel.adDismissed = false
        }
        
        .onChange(of: downloadComplete){ downloadComplete in
            if downloadComplete{
                if !premiumSubscriptionViewModel.isPro && interstititalModel.showAd(){
                    return
                }
                
                self.downloadComplete = false
                openTryOn = true
            }
        }
        
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Error"),
                message: Text(discoverViewModel.errorMessage),
                dismissButton: .default(Text("OK")) {
                    discoverViewModel.errorMessage = ""
                }
            )
        }
        
        .fullScreenCover(isPresented: $openTryOn){
            TryOnView(myTattooViewModel: DependencyContainer.shared.makeMyTattoosViewModel())
        }
        
        .confirmationDialog("", isPresented: $isDiscoverItemSelected){
            Button(action: {
                if self.downloadedTattoo != nil{
                    //open the try on view
                    //openTryOn = true
                    downloadComplete = true
                    
                }else{
                    if isSavingTattoo{
                        alertType = .error(message: NSLocalizedString("discover.downloading", comment: "downloading tatoo"))
                        return
                    }
                    
                    saveToGallery(buttonTapped: .tryOn)
                }
            }){
                Text("button.tryon")
            }
            
            Button(action: {
                if isSavingTattoo{
                    alertType = .error(message: NSLocalizedString("discover.downloading", comment: "downloading tatoo"))
                    return
                }
                
                saveToGallery(buttonTapped: .saveTattoo)
            }){
                Text("button.download")
            }
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4)){
                    dismiss()
                    
                    let tattooPrompt = selectedDiscoverItem?.tattooPrompt ?? ""
                    tattooPromptClosure(tattooPrompt)
                    
                }

            }){
                Text("button.useprompt")
            }
        }

        .alert(item: $alertType){ alert in
            switch alert {
            case .request_permission:
                return Alert(
                    title: Text(alert.title),
                    message: Text(alert.message),
                    primaryButton: .default(Text("allow.button")) {
                        PhotoLibraryPermissionManager.openSettings()
                        alertType = nil
                    },
                    secondaryButton: .cancel {
                        alertType = nil
                    }
                )
                
            case .error(let message):
                return Alert(
                    title: Text(alert.title),
                    message: Text(message),
                    dismissButton: .default(Text("ok.dismiss_button")) {
                        alertType = nil
                    }
                )
                
            default:
                return Alert(
                    title: Text(alert.title),
                    message: Text(alert.message),
                    dismissButton: .default(Text("ok.dismiss_button")) {
                        alertType = nil
                    }
                )
            }
        }
    }
    
    
    func saveToGallery(buttonTapped: ButtonTapped){
        guard let filenameURL = selectedDiscoverItem?.tattooUrl else{
            return
        }
        
        let selectedDiscoveryItemUrl = "\(BaseUrl.getBaseUrl(param: "image/download/\(filenameURL)"))"
        
        //check for permission
        if photoLibraryPermissionManager.status == .denied || photoLibraryPermissionManager.status == .restricted{
            
            alertType = .request_permission(message: NSLocalizedString("alert.request_permission.photo_save", comment: "Message asking the user to grant permission to save the photo"))
            
            return
        }
        
        isSavingTattoo = true
        ImageDownloader.downloadImage(urlString: selectedDiscoveryItemUrl, completion: { result in
            
            switch result{
            case .success(let image):
                ImageHelper.saveImageToGallery(image, completion: { status in
                    
                    isSavingTattoo = false
                    
                    if status{
                        
                        do{
                            try ImageHelper.saveImageToLocalDirectory(image: image, fileName: filenameURL, completion: { fileName, success in
                                
                                if success{
                                    
                                    self.downloadedTattoo = image
                                    
                                    if buttonTapped == .saveTattoo{
                                        alertType = .success(message: NSLocalizedString("alert.success.tattoo_saved", comment: "Message when tattoo is saved successfully"))
                                    }else{
                                        //openTryOn = true
                                        downloadComplete = true
                                    }
                                }else{
                                    alertType = .error(message: NSLocalizedString("alert.error_tattoo_saved", comment: "Tattoo Image already saved"))
                                    print("error saving")
                                }
                            })
                            
                        }catch{
                            alertType = .failure(message: error.localizedDescription)
                        }
                        
                    }else{
                        alertType = .request_permission(message: NSLocalizedString("alert.request_permission.save_photo", comment: "Message asking the user to grant permission to save the photo"))
                        
                    }
                })
                
            case .failure(let error):
                isSavingTattoo = false
                
                alertType = .failure(message: error.localizedDescription)
                
            }
        })
    }
    
    var sectionView: some View{
        VStack{
            ScrollView(.vertical){
                LazyVGrid(columns: rows){
                    ForEach(discoverViewModel.discoverItemList, id: \.self){ item in
                        DiscoverItemCardView(discoverItem: item)
                            .onTapGesture {
                                selectedDiscoverItem = item
                                isDiscoverItemSelected = true
                                self.downloadedTattoo = nil
                            }
                    }
                }
            }
            
        }.padding()
    }
}

#Preview {
    NavigationStack{
        DiscoverMoreView(
            discoverViewModel: DependencyContainer.shared.makeDiscoveryModel(), tattooStyleID: "mandala", tattooPromptClosure: { tattooPrompt in
                
            },
            
        )
    }
}
