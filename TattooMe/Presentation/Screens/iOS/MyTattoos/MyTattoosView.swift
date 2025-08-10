//
//  MyTattoos.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 03/07/2025.
//

#if os(iOS)
import SwiftUI
struct MyTattoosView: View{
    @Environment(\.dismiss) var dismiss
    @StateObject var myTattoosViewModel: MyTattoosViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var selectedTattoo: SavedTattooImage? = nil
    @State private var showSheet = false
    @State private var openTryOn = false
    
    init(myTattoosViewModel: MyTattoosViewModel) {
        _myTattoosViewModel = StateObject(wrappedValue: myTattoosViewModel)
    }
    
    var body: some View{
        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack{
                ScrollView{
                    LazyVGrid(columns: columns, spacing: AppSpacing.small){
                        ForEach(myTattoosViewModel.savedTattooURL, id: \.id){item in
                            MyTattoosCardView(savedTattoImage: item)
                                .onTapGesture {
                                    selectedTattoo = item
                                    showSheet = true
                                }
                        }
                    }
                }
                .toolbar{
                    ToolbarItemGroup(placement: .topBarLeading){
                        Text("mytattoos.my_tattoos.title")
                            .subTitleTextStyle()
                    }
                }
                
                .confirmationDialog("alert.confirmdialog.title", isPresented: $showSheet, titleVisibility: .visible){
                    
                    Button("button.delete", role: .destructive) {
                       
                        Task{
                            do{
                                if let imageUrl = selectedTattoo?.imageUrl{
                                    try myTattoosViewModel.deleteSavedTattoo(fileUrl: imageUrl)
                                    
                                    try await myTattoosViewModel.getAllSavedTattooURL()
                                }
                            }catch{
                                print("Error: \(error.localizedDescription)")
                            }
                        }
                    }
                   
                    Button("button.tryon") {
                        openTryOn = true
                    }
                    
                    Button("button.cancel", role: .cancel) {}
                }
            }
            
            if myTattoosViewModel.savedTattooURL.count == 0{
                VStack{
                    Text("error.no_data_found")
                        .bodyTextStyle()
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $openTryOn){
            TryOnView(myTattooViewModel: DependencyContainer.shared.makeMyTattoosViewModel())
        }
        
        .task {
            do{
                try await myTattoosViewModel.getAllSavedTattooURL()
            }catch{
                print("Failed to load tattoos:", error)
            }
        }
    }
}

#Preview {
    NavigationStack{
        MyTattoosView(myTattoosViewModel: DependencyContainer.shared.makeMyTattoosViewModel())
    }
}

#endif
