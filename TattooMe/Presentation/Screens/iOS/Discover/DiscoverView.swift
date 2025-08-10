//
//  ExploreView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//

import SwiftUI
struct DiscoverView: View{
    @StateObject var discoverViewModel: DiscoverViewModel
    let verticalGridRows = [
        GridItem(.flexible()),
    ]
    
    let horizontalGridRows = [
        GridItem(.flexible()),
    ]
    
    @State var selectedDiscoveryItem: DiscoverItem?
    @State var isDiscoveryItemSelected = false
    @State var selectedTattooStyleID: String?
    @State var navigationPath = NavigationPath()
    @State private var showError = false
    @State private var downloadedTattoo: UIImage?
    @State var alertType: AlertType?
    @State var subscriptionPackage: SubscriptionPackage?
    @StateObject var photoLibraryPermissionManager = PhotoLibraryPermissionManager()
    @State var isSavingTattoo: Bool = false
    @State var openTryOn = false
    @State var downloadComplete = false
    @State var isProActive = false
    @StateObject var interstititalModel = InterstitialViewModel()
    @StateObject var premiumSubscriptionViewModel = PremiumSubscriptionViewModel()
    
    @Binding var selectedTab: Int
    @Binding var tattooPrompt: String

    var body: some View{
        NavigationStack(path: $navigationPath){
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
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Text("discover.title")
                        .titleTextStyle()
                }
            }
            
            .confirmationDialog("alert.confirmdialog.title", isPresented: $isDiscoveryItemSelected){
                Button(action: {
                    
                    if self.downloadedTattoo != nil{
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
                        selectedTab = 0
                        tattooPrompt = selectedDiscoveryItem?.tattooPrompt ?? ""
                    }

                }){
                    Text("button.useprompt")
                }
                
            }
            
            .task {
                await discoverViewModel.getTattoosDiscover()
                await premiumSubscriptionViewModel.checkSubscriptionStatus()
                await interstititalModel.loadAd()
            }
            
            .onChange(of: discoverViewModel.errorMessage) { newValue in
                guard !newValue.isEmpty else { return }
                alertType = .error(message: newValue)
                discoverViewModel.errorMessage = ""
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
            
            .navigationDestination(for: String.self){ item in
                DiscoverMoreView(discoverViewModel: DependencyContainer.shared.makeDiscoveryModel(), tattooStyleID: item, tattooPromptClosure: { value in
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                        selectedTab = 0
                        tattooPrompt = value
                    }
                })
            }
            
            
            .fullScreenCover(isPresented: $openTryOn){
                TryOnView(myTattooViewModel: DependencyContainer.shared.makeMyTattoosViewModel())
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
    }
    
    func saveToGallery(buttonTapped: ButtonTapped){
        guard let filenameURL = selectedDiscoveryItem?.tattooUrl else{
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
                                        
                                        downloadComplete = true
                                        print("donwload complete")
                                        //openTryOn = true
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
            ScrollView{
                LazyVGrid(columns: verticalGridRows, spacing: AppSpacing.large){
                    ForEach(discoverViewModel.discoverList){ section in
                        
                        VStack(alignment: .leading){
                            
                            HStack{
                                let localizedStyleName = NSLocalizedString("tattoo_style.\(section.tattooStyle).name", comment: "")
                                
                                Text(localizedStyleName)
                                    .subTitleTextStyle()
                                    .padding(EdgeInsets(top: 0, leading: AppSpacing.medium, bottom: 0, trailing: 0))
                                
                                Spacer()
                                Button(action: {
                                    navigationPath = NavigationPath()
                                    navigationPath.append(section.tattooStyle)

                                }){
                                    Text("button.more")
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundStyle(Color.white)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: AppSpacing.small, leading: 0, bottom: 0, trailing: AppSpacing.small))
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                LazyHGrid(rows: horizontalGridRows, spacing: AppSpacing.small){
                                    ForEach(section.discoverItemsList.indices, id: \.self){ indices in
                                        DiscoverItemCardView(discoverItem: section.discoverItemsList[indices])
                                            .onTapGesture{
                                                isDiscoveryItemSelected = true
                                                selectedDiscoveryItem  = section.discoverItemsList[indices]
                                                self.downloadedTattoo = nil
                                            }
                                        
                                    }
                                }
                            }
                            .padding(.init(top: 0, leading: AppSpacing.small, bottom: AppSpacing.small, trailing: AppSpacing.small))
                        }
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(AppRadius.medium)
                    }
                }
            }
        }
    }
}


enum ButtonTapped{
    case saveTattoo
    case tryOn
    
}

#Preview {
    NavigationStack{
        DiscoverView(
            discoverViewModel: DependencyContainer.shared.makeDiscoveryModel(), selectedTab: .constant(0), tattooPrompt: .constant("")
        )
    }
}
