//
//  ProcessingTattoo.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 04/07/2025.
//

#if os(iOS)
import SwiftUI
import GoogleMobileAds
import Kingfisher

struct ProcessingTattooView: View{
    var tattooStyle: TattooStyle
    var tattooPrompt: String
    
    @Environment(\.dismiss) var dismiss
    @StateObject var processingTattooViewModel: ProcessingTattooViewModel
    @StateObject var premiumSubscriptionViewModel = PremiumSubscriptionViewModel()
    @StateObject var photoLibraryPermissionManager = PhotoLibraryPermissionManager()
    var shouldPrompt: Bool = false
    @State var showErrorAlert = false
    @State var alertType: AlertType?
    @State var isSavingTattoo: Bool = false
    @State var openTryOnView = false
    @State private var downloadedTattoo: UIImage?
    
    var body: some View{
        ZStack{
            Colors.primary.ignoresSafeArea()
            sectionView
        }
        
        .toolbar{
            ToolbarItemGroup(placement: .topBarLeading){
                Button(action: {
                    
                    if processingTattooViewModel.isLoading {
                        alertType = .loading
                        return
                    }
                    
                    processingTattooViewModel.myTattoo = nil
                    dismiss()
                }){
                    Image(systemName: "chevron.left").backIconstyle()
                }
                
                Text("processing_tattoo.title").titleTextStyle()
            }
            
        }
        
        
        .task {
            let prompt = Prompt(requestID: UUID().uuidString, promptText: tattooPrompt, tattooStyle: tattooStyle.tattooStyleIcon, tattooDescription: tattooStyle.tattooDescription)
            
            await premiumSubscriptionViewModel.checkSubscriptionStatus()
            
            if !shouldPrompt{
                print("should not prompt")
                return
            }
            
            do {
                try await processingTattooViewModel.getTattooByPrompt(prompt: prompt)
                
                processingTattooViewModel.updateGenerationLimit()
                
                if processingTattooViewModel.requestAppReview(){
                    RateApp.requestAppReview()
                }
                
            } catch {
                print("Failed to fetch tattoo: \(error.localizedDescription)")
                alertType = .error(message: error.localizedDescription)
            }
        }
        
        .navigationBarBackButtonHidden(true)
       
        
        .alert(item: $alertType) { alert in
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
                        dismiss()
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
        
        
        .fullScreenCover(isPresented: $openTryOnView){
            TryOnView(myTattooViewModel: DependencyContainer.shared.makeMyTattoosViewModel())
        }
    }
    
    var sectionView: some View{
        GeometryReader{ geometry in
            VStack{
                ScrollView{
                    VStack(spacing: AppSpacing.medium){
                        KFImage(URL(string: processingTattooViewModel.myTattoo?.MyTattooUrl ?? ""))
                            .resizable()
                            .placeholder{
                                Image("splash_one")
                                    .resizable()
                                    .scaledToFit()
                                    .blur(radius: AppRadius.medium)
                                    .overlay(
                                        VStack{
                                            ProgressView().progressViewStyle(CircularProgressViewStyle())
                                                .tint(.white)
                                            Text(alertType == nil ? NSLocalizedString("alert.generating_tattoo", comment: "Message when tattoo is being generated") : "")
                                                .bodyTextStyle()

                                            
                                        })
                                
                            }
                            .scaledToFit()
                            .frame(height: geometry.size.height * 0.4).cornerRadius(AppRadius.medium)
                        
                        
                        if !premiumSubscriptionViewModel.isPro{
                            Rectangle()
                                .frame(height: AdsSize.bannersAdsContainerHeight)
                                .overlay(
                                    BannerAdView(adUnit: Ads.bannerAdGenerate, adSize: AdSizeBanner)
                                        .frame(width: AdSizeBanner.size.width, height: AdsSize.bannersAdsHeight)
                                )
                        }
                    }
                }
                
                HStack{
                    Button(action: {
                        if processingTattooViewModel.isLoading {
                            alertType = .loading
                            return
                        }
                        
                        processingTattooViewModel.myTattoo = nil
                        dismiss()
                    }){
                        VStack(spacing: AppSpacing.small){
                            Image(systemName: "arrow.clockwise")
                            Text("button.recreate")
                                .bodyTextStyle()
                        }
                    }
                    .primaryButtonStyle()
                    
                    Button(action: {
                       
                        if downloadedTattoo != nil{
                            alertType = .success(message: NSLocalizedString("alert.success.tattoo_saved", comment: "Message when tattoo is saved successfully"))
                            return
                        }
                        
                        saveImage(buttonTapped: .saveTattoo)
                    }){
                        VStack(spacing: AppSpacing.small){
                            Image(systemName: "square.and.arrow.down")
                            Text(isSavingTattoo ? NSLocalizedString("tattoo.saving", comment: "Message displayed when saving a tattoo") : NSLocalizedString("tattoo.save", comment: "Button text to save a tattoo"))
                        }

                    }.primaryButtonStyle()
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    //try on body
                    Button(action: {
                        if downloadedTattoo != nil{
                            openTryOnView = true
                            return
                        }
                        
                        saveImage(buttonTapped: .tryOn)
                    }){
                        VStack(spacing: AppSpacing.small){
                            Image(systemName: "cube")
                            Text("button.tryon")
                        }
                    }
                    .primaryButtonStyle()
                }
            }
        }
    }
    
    enum ButtonTapped{
        case saveTattoo
        case tryOn
    }
    
    func saveImage(buttonTapped: ButtonTapped){
    
           if processingTattooViewModel.isLoading {
               alertType = .loading
               return
           }
           
           guard let urlString = processingTattooViewModel.myTattoo?.MyTattooUrl, !urlString.isEmpty else{
               alertType = .error(message: NSLocalizedString("alert.invalid_prompt", comment: "Message for invalid prompt error"))

               return
           }
           
           if photoLibraryPermissionManager.status == .denied || photoLibraryPermissionManager.status == .restricted{
               
               alertType = .request_permission(message: NSLocalizedString("alert.request_permission.photo_save", comment: "Message asking the user to grant permission to save the photo"))

               return
           }
           
           //save tattoo to local storage
           
           isSavingTattoo = true
           ImageDownloader.downloadImage(urlString: urlString, completion: { result in
               
               switch result{
               case .success(let image):
                   ImageHelper.saveImageToGallery(image, completion: { status in
                       
                       isSavingTattoo = false

                       if status{
                           
                           do{
                              try ImageHelper.saveImageToLocalDirectory(image: image, fileName: UUID().uuidString, completion: { fileName, success in
                                  
                                  if success{
                                      
                                      self.downloadedTattoo = image
                                      
                                      switch buttonTapped {
                                      case .saveTattoo:
                                          alertType = .success(message: NSLocalizedString("alert.success.tattoo_saved", comment: "Message when tattoo is saved successfully"))
                                      case .tryOn:
                                          openTryOnView = true
                                      }
                                      //save to core data
                                      
                                  }else{
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
}

#Preview {
    NavigationStack{
        let tattooStyle = TattooStyle(tattooStyleIcon: "", tattooStyleName: "", tattooDescription: "")
        
        let processingTattooViewModel = DependencyContainer.shared.makeProcessingTattooModel()
        
        ProcessingTattooView(tattooStyle: tattooStyle, tattooPrompt: "hello there", processingTattooViewModel: processingTattooViewModel)
    }
}

#endif
