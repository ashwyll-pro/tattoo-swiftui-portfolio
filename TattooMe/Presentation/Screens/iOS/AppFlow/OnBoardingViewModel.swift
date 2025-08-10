//
//  OnBoardingViewModel.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 27/06/2025.
//

import Foundation

class OnBoardingViewModel: ObservableObject {
    @Published var onBoardingViewItems = [
        OnBoardingItem(
            title: NSLocalizedString("onboarding.generate_ai_tattoos.title", comment: "Title for AI tattoo generation onboarding"),
            description: NSLocalizedString("onboarding.generate_ai_tattoos.description", comment: "Description for AI tattoo generation onboarding"),
            image: "splash_one"
        ),
        OnBoardingItem(
            title: NSLocalizedString("onboarding.browse_styles.title", comment: "Title for browsing tattoo styles onboarding"),
            description: NSLocalizedString("onboarding.browse_styles.description", comment: "Description for browsing tattoo styles onboarding"),
            image: "splash_two"
        ),
        OnBoardingItem(
            title: NSLocalizedString("onboarding.save_and_organize.title", comment: "Title for saving and organizing tattoos onboarding"),
            description: NSLocalizedString("onboarding.save_and_organize.description", comment: "Description for saving and organizing tattoos onboarding"),
            image: "splash_five"
        )
    ]
}

