//
//  PhotoLibraryPermissionManager.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 21/07/2025.
//

import Photos
import SwiftUI

@MainActor
final class PhotoLibraryPermissionManager: ObservableObject {
    enum PermissionStatus: String {
        case authorized = "Full Access"
        case limited = "Limited Access"
        case denied = "Denied"
        case restricted = "Restricted"
        case notDetermined = "Not Determined"
    }
    
    @Published private(set) var status: PermissionStatus = .notDetermined
    
    init() {
        Task {
            await checkCurrentPermission()
        }
    }
    
    func checkCurrentPermission() async {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        updateStatus(from: status)
    }
    
    func requestPermission() async {
        let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        updateStatus(from: status)
    }
    
    private func updateStatus(from authStatus: PHAuthorizationStatus) {
        switch authStatus {
        case .authorized:
            status = .authorized
        case .limited:
            status = .limited
        case .denied:
            status = .denied
        case .restricted:
            status = .restricted
        case .notDetermined:
            status = .notDetermined
        @unknown default:
            status = .notDetermined
        }
    }
    
    var canSaveToLibrary: Bool {
        status == .authorized || status == .limited
    }
    
    static func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsUrl) else {
            return
        }
        UIApplication.shared.open(settingsUrl)
    }
}
