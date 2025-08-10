//
//  ParsePriceString.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 20/07/2025.
//

final class ParsePriceString{
    static func parsePriceString(_ price: String) -> Double? {
        let filtered = price.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
        return Double(filtered)
    }
}
