//
//  Styles.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 03/07/2025.
//

import SwiftUI
struct PrimaryButtonStyle: ViewModifier{
    func body(content: Content) -> some View{
        content.padding(AppSpacing.medium)
            .background(Gradients.primarySecondaryButtonLinearGradient)
            .foregroundColor(Colors.buttonForegroundPrimaryColor)
            .cornerRadius(AppRadius.medium)
            .fontWeight(.bold)
            .contentShape(Rectangle())
    }
}

struct MacPrimaryButtonStyle: ViewModifier{
    func body(content: Content) -> some View{
        content.padding(AppSpacing.small)
            .background(Gradients.primarySecondaryButtonLinearGradient)
            .foregroundColor(Colors.buttonForegroundPrimaryColor)
            .cornerRadius(AppRadius.small)
            .fontWeight(.bold)
            .contentShape(Rectangle())
    }
}

struct SecondaryButtonStyle: ViewModifier{
    var width: CGFloat
    
    func body(content: Content) -> some View{
        content.padding(AppSpacing.medium)
        .background(Colors.buttonBackgroundPrimaryColor)
        .foregroundColor(Colors.buttonForegroundPrimaryColor)
        .cornerRadius(AppRadius.medium)
        .frame(width: width)
        .contentShape(Rectangle())
    }
}

struct TertiaryButtonStyle: ViewModifier{
    var width: CGFloat
    
    func body(content: Content) -> some View{
        content.padding(AppSpacing.medium)
            .background(Color.white)
            .foregroundColor(Color.black)
        .cornerRadius(AppRadius.medium)
        .frame(width: width)
        .contentShape(Rectangle())
    }
}

struct PrimaryIconStyle: ViewModifier{
    func body(content: Content) -> some View {
        content.foregroundColor(Colors.iconsForegroundPrimaryColor)
    }
}

struct BackIconStyle: ViewModifier{
    func body(content: Content) -> some View {
        content.foregroundStyle(Color.gray)
    }
}

struct TitleTextStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: TextSize.xLarge, weight: .bold, design: .default))
            .foregroundColor(Colors.textForegroundPrimary)
    }
}

struct SubTitleStyle: ViewModifier{
    func body(content: Content) -> some View {
        content.font(.system(size: TextSize.large, weight: .bold))
            .foregroundColor(Colors.textForegroundPrimary)
    }
}

struct BodyTextStyle: ViewModifier{
    func body(content: Content) -> some View{
        content.font(.system(size: TextSize.medium))
            .foregroundColor(Colors.textForegroundPrimary)
    }
}

struct CaptionTextStyle: ViewModifier{
    func body(content: Content) -> some View {
        content.font(.system(size: TextSize.small))
            .foregroundColor(Colors.textForegroundPrimary)
    }
}

extension View{
    func primaryButtonStyle() -> some View{
        self.modifier(PrimaryButtonStyle())
    }
    
    func macPrimaryButtonStyle() -> some View{
        self.modifier(MacPrimaryButtonStyle())
    }
    
    func secondaryButtonStyle(width: CGFloat) -> some View{
        self.modifier(SecondaryButtonStyle(width: width))
    }
    
    func tertiaryButtonStyle(width: CGFloat) -> some View{
        self.modifier(TertiaryButtonStyle(width: width))
    }
    
    func iconPrimaryStyle() -> some View{
        self.modifier(PrimaryIconStyle())
    }
    
    func backIconstyle() -> some View{
        self.modifier(BackIconStyle())
    }
    
    func titleTextStyle() -> some View{
        self.modifier(TitleTextStyle())
    }
    
    func subTitleTextStyle()->some View{
        self.modifier(SubTitleStyle())
    }
    
    func bodyTextStyle() -> some View{
        self.modifier(BodyTextStyle())
    }
    
    func captionTextStyles() -> some View{
        self.modifier(CaptionTextStyle())
    } 
}
