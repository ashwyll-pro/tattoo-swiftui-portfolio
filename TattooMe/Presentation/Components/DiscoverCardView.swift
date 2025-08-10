//
//  DiscoveryCardView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//

import SwiftUI
import Kingfisher
struct DiscoverItemCardView: View{
    let discoverItem: DiscoverItem
    var body: some View{
        ZStack{
            VStack{
                KFImage(URL(string: "\(BaseUrl.getBaseUrl(param: "image/"))\(discoverItem.tattooUrl)"))
                    .placeholder{
                        Image(systemName: "photo.trianglebadge.exclamationmark")
                            .resizable()
                            .scaledToFit()
                            .clipped()
                            .foregroundStyle(Color.white)
                    }
                    .resizable()
                    .scaledToFit()
                
            }
            .frame(width: 120, height: 120)
            .cornerRadius(AppRadius.medium)
        }
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        DiscoverItemCardView(discoverItem: DiscoverItem(tattooUrl: "", tattooPrompt: ""))
    }
}
