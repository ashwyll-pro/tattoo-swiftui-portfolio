
#if os(iOS)
import SwiftUI
import GoogleMobileAds

struct TattooGenerationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""
    @State var tattooStyle: TattooStyle?
    @State private var isProActive = false
    @State private var showToast = false
    @State private var showGenerationLimitAlert = false
    @State var showLimitedOffer = false
    @State var subscriptionPackage: SubscriptionPackage?
    @StateObject var premiumSubscriptionViewModel = PremiumSubscriptionViewModel()
    @StateObject var tattooGenerationViewModel: TattooGenerationViewModel
    @StateObject var processingTattooViewModel: ProcessingTattooViewModel
    @StateObject var rewardedViewModel = RewardedViewModel()
    @StateObject var networkMonitorModel = NetworkMonitorModel()
    
    @FocusState private var isTextFieldFocused: Bool
    @State var subscriptionOrAdPopupShow = false
    @State var generateTattooNavigate = false
    
    @State private var hasSyncedPrompt = false
    @State private var openNetworkConnectionView = false
    
    @Binding var tattooPrompt: String

    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                sectionView
                
                if subscriptionOrAdPopupShow{
                    SubscriptionOrAdPopupView(watchAdClosure: {
                        subscriptionOrAdPopupShow = false
                        rewardedViewModel.showAd(onReward: { status in
                            if status{
                                generateTattooNavigate = true
                            }
                        })
                    }, removeLimitClosure: {
                        subscriptionOrAdPopupShow = false
                        isProActive = true
                    },
                    dismissView: {
                        withAnimation{
                            self.subscriptionOrAdPopupShow = false
                        }
                    })
                }
            }
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Text(AppName.appName).titleTextStyle()
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    if !premiumSubscriptionViewModel.isPro{
                        Button(action: {
                            isProActive = true
                        }){
                            Text("subscription.pro.button").iconPrimaryStyle()
                        }
                    }
                }
            }
            
            .fullScreenCover(isPresented: $generateTattooNavigate){
                NavigationStack{
                    ProcessingTattooView(tattooStyle: tattooStyle!, tattooPrompt: searchText, processingTattooViewModel: processingTattooViewModel, shouldPrompt: true)
                }
            }

            .fullScreenCover(isPresented: $isProActive){
                PremiumSubscriptionView(onClose: { package in
                    if package == nil{
                        return
                    }
                    self.subscriptionPackage = package
                    showLimitedOffer = true
                },
                                        proSubscribed: {
                    premiumSubscriptionViewModel.isPro = true
                })
            }
            
            .fullScreenCover(isPresented: $openNetworkConnectionView){
                InternetConnectionView{ connectionStatus in
                    if connectionStatus{
                        Task{
                            await loadInitialData()
                        }
                    }
                }
            }
            
            
            .toast(isPresented: $showToast, message: NSLocalizedString("tattoo_generation.description.toast", comment: ""), alignment: .top)
            
            .sheet(isPresented: $showLimitedOffer){
                LimitedOfferView(onSubscribe: {
                    premiumSubscriptionViewModel.isPro = true
                }, subscriptionPackage: self.subscriptionPackage)
                .presentationBackground(.ultraThinMaterial)
            }
            
            .alert("alert.generation_limit.title", isPresented: $showGenerationLimitAlert) {
                Button("alert.generation_limit.button.upgrade", action: {
                    isProActive = true
                })
                Button("alert.generation_limit.button.try_tomorrow", role: .cancel, action: {})
            } message: {
                Text("alert.generation_limit.message")
            }
            
            .onTapGesture {
                isTextFieldFocused = false // dismiss on tap outside
            }
            
            .task {
                    await loadInitialData()
            }
            
            .onAppear {
               
                if !tattooPrompt.isEmpty {
                    searchText = tattooPrompt
                }
                
                if hasSyncedPrompt{return}
                
                if !premiumSubscriptionViewModel.isPro{
                    //isProActive = true
                }
                
                hasSyncedPrompt = true
            }
            
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func loadInitialData() async {
        do {
            try await tattooGenerationViewModel.getTattooStyle()
            self.tattooStyle = tattooGenerationViewModel.tattooDesignItems.first
        } catch {
            print("Error: \(error.localizedDescription)")
        }

        await premiumSubscriptionViewModel.checkSubscriptionStatus()
        await rewardedViewModel.loadAd()
    }
    
    var sectionView: some View{
        
        GeometryReader{ geometry in
            VStack {
                ScrollView{
                    Text("tattoo_generation.textfield.title")
                        .captionTextStyles()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, AppSpacing.large)
                        .padding(.top, AppSpacing.small)
                    
                    ZStack(alignment: .topLeading){
                        
                        TextEditor(text: $searchText)
                            .focused($isTextFieldFocused)
                            .scrollContentBackground(.hidden)
                            .background(Color(hex: "#333333"))
                            .cornerRadius(AppRadius.medium)
                            .bodyTextStyle()
                            .overlay(
                                RoundedRectangle(cornerRadius: AppRadius.medium)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                            )
                        
                        searchTextView
                        
                        VStack{
                            Spacer()
                            
                            HStack{
                                Button(action: {
                                    searchText = "A \(TattooIdeas.all.randomElement() ?? "Lion face") "
                                }){
                                    Text("tattoo_generation.suggestions.button")
                                }.primaryButtonStyle()
                                    .padding(.leading, AppSpacing.medium)
                                    .padding(.bottom, AppSpacing.medium)
                                
                                Spacer()
                                
                                if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    Button(action: {
                                        searchText = " "
                                    }){
                                        Image(systemName: "xmark")
                                    }.backIconstyle()
                                        .frame(width: 30, height: 30)
                                        .padding()
                                        .background(Color.black.opacity(0.1))
                                        .cornerRadius(AppRadius.medium)
                                }
                            }
                        }
                    }
                    .padding(.leading, AppSpacing.small)
                    .padding(.trailing, AppSpacing.small)
                    .padding(.bottom)
                    .frame(width: geometry.size.width, height:  geometry.size.height * 0.4)
                    
                    //add tattoo styles
                    Text("dashboard.tattoo_styles.title")
                        .subTitleTextStyle()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, AppSpacing.small)
                    
                    Text("dashboard.select_style.label").captionTextStyles()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    ScrollViewReader{ scrollProxy in
                        ScrollView(.horizontal, showsIndicators: false){
                            LazyHGrid(rows: [GridItem(.fixed(120))]){
                                ForEach(tattooGenerationViewModel.tattooDesignItems){ item in
                                    TattoStyleCardView(item: item, selectedTattooStyle: self.tattooStyle!)
                                        .frame(width: 120)
                                        .id(item.id)
                                        .onTapGesture {
                                            withAnimation{
                                                self.tattooStyle = item
                                                scrollProxy.scrollTo(item.id, anchor: .center)
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .padding(.leading, AppSpacing.small)
                    
                    if !premiumSubscriptionViewModel.isPro{
                        GeometryReader{ geometry in
                            Rectangle()
                                .frame(width: geometry.size.width, height: AdsSize.bannersAdsContainerHeight)
                                .cornerRadius(AppRadius.medium)
                                .overlay(
                                    BannerAdView(adUnit: Ads.bannerAdHome, adSize: AdSizeBanner)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                        .padding()
                                )
                        }
                        .frame(height: AdsSize.bannersAdsContainerHeight)
                    }
                }
                
                Spacer()
                Button(action: {
                    if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                        showToast = true
                        return
                    }
                    
                    processingTattooViewModel.updateGenerationLimit()
                    
                    //                    if !premiumSubscriptionViewModel.isPro{
                    //                        let limit = tattooGenerationViewModel.checkGenerationLimitHit()
                    //
                    //                        if limit{
                    //                            showGenerationLimitAlert = true
                    //                            return
                    //                        }
                    //                    }
                    
                    if !networkMonitorModel.isConnected{
                       
                        //navigate to network connection view
                        openNetworkConnectionView = true
                        return
                    }
            
                    if !premiumSubscriptionViewModel.isPro{
                        //show
                        subscriptionOrAdPopupShow = true
                        return
                    }
                    
                    generateTattooNavigate = true

                }){
                    HStack{
                        Image(systemName: "apple.intelligence")
                        Text("tattoo_generation.generate_button")
                    }
                    .frame(width: geometry.size.width * 0.8)
                    .primaryButtonStyle()
                    .padding()
                }
            }
        }
    }
    
    var searchTextView: some View{
        VStack{
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text("tattoo_generation.textfield.hint")
                    .foregroundStyle(Color.gray)
                    .padding(AppSpacing.small)
            }
        }
    }
}


#Preview {
    
    let tattooStyle = TattooStyle(tattooStyleIcon: "mandala", tattooStyleName: "style one", tattooDescription: "")
    let tattooGenerationViewModel = DependencyContainer.shared.makeTattooGenerationModel()
    let processingTattooViewModel = DependencyContainer.shared.makeProcessingTattooModel()
    
    TattooGenerationView(tattooStyle: tattooStyle, tattooGenerationViewModel: tattooGenerationViewModel, processingTattooViewModel: processingTattooViewModel, tattooPrompt: .constant("") ).frame(maxWidth: .infinity, maxHeight: .infinity)
}

#endif
