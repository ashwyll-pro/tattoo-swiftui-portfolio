//
//  NetworkMonitor.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 04/08/2025.
//

import Foundation
import Network

class NetworkMonitorModel: ObservableObject {
    private var monitor = NWPathMonitor()
    private var queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected: Bool = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
