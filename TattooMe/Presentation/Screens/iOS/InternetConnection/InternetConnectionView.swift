//
//  InternetConnectionView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 04/08/2025.
//

import SwiftUI
struct InternetConnectionView: View{
    @Environment(\.dismiss) var dismiss
    var connectionClosure: (Bool)->Void?
    @StateObject var networkMonitorModel = NetworkMonitorModel()
   
    var body: some View{
        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack(spacing: AppSpacing.medium){
                Image(systemName: "wifi.exclamationmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100,height: 100)
                    .foregroundStyle(Color.red)
                
                
                Text("internet_connection.title")
                    .titleTextStyle()
                
                Text("internet_connection.subtitle").bodyTextStyle()
                
                Button(action: {
                    //check if you are connected
                    if networkMonitorModel.isConnected{
                        withAnimation{
                            dismiss()
                            connectionClosure(true)
                        }
                    }
                    
                }){
                    Text("button.retry").primaryButtonStyle()
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    InternetConnectionView(connectionClosure: { status in
    })
}
