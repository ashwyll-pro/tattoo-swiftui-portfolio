//
//  AlertType.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 15/07/2025.
//

import Foundation

enum AlertType: Identifiable {
    case loading
    case error(message: String)
    case success(message: String)
    case failure(message: String)
    case request_permission(message: String)
    case daily_limit(message: String)
    
    var id: String {
        switch self {
        case .loading:
            return "loading"
        case .error(let message):
            return "error-\(message)"
        case .success(let message):
            return message
        case .failure(let message):
            return "error-\(message)"
        case .request_permission:
            return "request_permission"
        case .daily_limit(let message):
            return message
        }
    }
    
    var title: String {
        switch self {
        case .loading:
            return NSLocalizedString("alert.loading.title", comment: "Title for loading state")
        case .error(_):
            return NSLocalizedString("alert.error.title", comment: "Title for error alert")
        case .success(_):
            return NSLocalizedString("alert.success.title", comment: "Title for success alert")
        case .failure(_):
            return NSLocalizedString("alert.failure.title", comment: "Title for failure alert")
        case .request_permission(_):
            return NSLocalizedString("alert.request_permission.title", comment: "Title for request permission alert")
        case .daily_limit(_):
            return NSLocalizedString("alert.daily_limit.title", comment: "Title for daily limit reached alert")
        }
    }
    
    var message: String {
        switch self {
        case .loading:
            return NSLocalizedString("alert.loading.message", comment: "Message for loading state")
        case .error(let message):
            return NSLocalizedString("alert.error.message", comment: "Message for error alert") + ": \(message)"
        case .success(let message):
            return message
        case .failure(let message):
            return message
        case .request_permission(let message):
            return message
        case .daily_limit(let message):
            return message
        }
    }
}
