//
//  WindowApplication.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 04/08/2025.
//

import UIKit

extension UIApplication {
    var rootViewController: UIViewController? {
        // Get connected scenes
        guard let windowScene = connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }),
              let rootVC = windowScene
                .windows
                .first(where: { $0.isKeyWindow })?
                .rootViewController else {
            return nil
        }
        return rootVC
    }
}
