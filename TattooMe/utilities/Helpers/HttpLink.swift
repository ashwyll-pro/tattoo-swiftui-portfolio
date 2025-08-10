//
//  HttpLink.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 20/07/2025.
//

import Foundation
import UIKit

class HttpLink{
   static func openHttpLink(link: String){
        guard let url = URL(string: link) else{
            return
        }
        
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
