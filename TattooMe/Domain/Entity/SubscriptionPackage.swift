import RevenueCat
import Foundation

struct SubscriptionPackage: Identifiable{
    var id = UUID()
    private(set) var isSelected: Bool
    let packageType: PackageType
    let packagePrice: String
    var rcPackage: Package
    
    init(isSelected: Bool, packageType: PackageType, packagePrice: String, rcPackage: Package) {
        self.isSelected = isSelected
        self.packageType = packageType
        self.packagePrice = packagePrice
        self.rcPackage = rcPackage
    }
    
    var title: String {
        switch packageType {
        case .annual:
            return "Yearly Plan"
        case .weekly:
            return "Weekly Plan"
        default:
            return "Unknown Plan"
        }
    }
    
    var subtitle: String {
        switch packageType {
        case .annual:
            if let priceValue = ParsePriceString.parsePriceString(packagePrice) {
                let weekly = priceValue / 52.0
                return "Just \(FormatPrice.formatPrice(weekly)) per week"
            } else {
                return "Just per week"
            }
        case .weekly:
            return "\(FormatPrice.formatPrice(ParsePriceString.parsePriceString(packagePrice) ?? 0)) per week"
        default:
            return "Unknown"
        }
    }
    
    var duration: String {
        switch packageType {
        case .annual:
            return "per year"
        case .weekly:
            return "per week"
        default:
            return "unknown"
        }
    }
    
    mutating func select() {
        isSelected = true
    }
    
    mutating func deselect() {
        isSelected = false
    }
}
