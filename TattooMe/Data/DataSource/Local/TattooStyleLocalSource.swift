//
//  TattooStyleLocalSource.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//
import Foundation
struct TattooStyleLocalSource {
    func tattooStyleLocalSource() -> [TattooStyle] {
        let icons = [
            "tribal",
            "american_traditional",
            "neo_traditional",
            "irezumi",
            "blackwork",
            "realism",
            "surrealism",
            "trash_polka",
            "portrait",
            "watercolor",
            "minimalist",
            "fine_line",
            "illustrative_sketch",
            "geometric",
            "dotwork",
            "abstract",
            "biomechanical",
            "glitch_pixel",
            "negative_space",
            "uv_backlight",
            "chicano",
            "arabic_caligraphy",
            "thai_sak_yant",
            "celtic",
            "mandala"
        ]

        return icons.map { icon in
            TattooStyle(
                tattooStyleIcon: icon,
                tattooStyleName: localizedTattooName(for: icon),
                tattooDescription: localizedTattooDescription(for: icon)
            )
        }
    }
    
    func localizedTattooName(for icon: String) -> String {
        NSLocalizedString("tattoo_style.\(icon).name", comment: "")
    }

    func localizedTattooDescription(for icon: String) -> String {
        NSLocalizedString("tattoo_style.\(icon).description", comment: "")
    }
}

