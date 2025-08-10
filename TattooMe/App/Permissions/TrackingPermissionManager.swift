//
//  TrackingPermissionManager.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 10/07/2025.
//

#if os(iOS)
import Foundation
import AppTrackingTransparency

class TrackingPermissionManager: ObservableObject{
    @Published var trackingStatus: ATTrackingManager.AuthorizationStatus = .notDetermined

    func requestTrackingPermission() {
           ATTrackingManager.requestTrackingAuthorization { status in
               DispatchQueue.main.async {
                   self.trackingStatus = status
               }
           }
       }
}

#endif
