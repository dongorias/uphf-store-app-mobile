//
//  AppTheme.swift
//  Store
//
//  Created by Don Arias Agokoli on 23/12/2024.
//

import SwiftUI

// Extension to define custom fonts
extension Font {
    static let generalSans = "GeneralSansVariable-Bold_Regular"
    
    static func customFont(_ name: String? = nil, size: CGFloat, weight: Font.Weight = .regular) -> Font {
        let fontName = name ?? generalSans
        return .custom(fontName, size: size).weight(weight)
    }
    
}
    // Theme structure to hold all styling information
    struct AppTheme {
        // Colors
        static let accent = Color("AccentColor", bundle: nil)
        static let foreground = Color(.black)
        
//        GeneralSansVariable-Bold_Regular
//        GeneralSansVariable-Bold_Extralight
//        GeneralSansVariable-Bold_Light
//        GeneralSansVariable-Bold_Medium
//        GeneralSansVariable-Bold_Semibold
//        GeneralSansVariable-Bold
        
        // Text Styles
        struct TextStyle {
            
            static func header1(fontName: String? = nil) -> TextStyle {
                TextStyle(
                    font: Font.customFont("GeneralSansVariable-Bold_Semibold", size: 64, weight: .semibold),
                    foregroundColor: foreground
                )
            }
            
            static func header2(fontName: String? = nil) -> TextStyle {
                TextStyle(
                    font: Font.customFont("GeneralSansVariable-Bold_Semibold", size: 32, weight: .semibold),
                    foregroundColor: foreground
                )
            }
            
            static func header3(fontName: String? = nil) -> TextStyle {
                TextStyle(
                    font: Font.customFont("GeneralSansVariable-Bold_Semibold", size: 24, weight: .semibold),
                    foregroundColor: foreground
                )
            }   
            static func header4(fontName: String? = nil) -> TextStyle {
                TextStyle(
                    font: Font.customFont("GeneralSansVariable-Bold_Medium", size: 20, weight: .medium),
                    foregroundColor: foreground
                )
            }
            
            static func body1(fontName: String? = nil) -> TextStyle {
                TextStyle(
                    font: Font.customFont("GeneralSansVariable-Bold_Regular", size: 16, weight: .regular),
                    foregroundColor: foreground
                )
            }
            
            static func body2(fontName: String? = nil) -> TextStyle {
                TextStyle(
                    font: Font.customFont("GeneralSansVariable-Bold_Regular", size: 14, weight: .regular),
                    foregroundColor: foreground
                )
            }
            static func body3(fontName: String? = nil) -> TextStyle {
                TextStyle(
                    font: Font.customFont("GeneralSansVariable-Bold_Regular", size: 12, weight: .regular),
                    foregroundColor: foreground
                )
            }
           
           
            
            static func button(fontName: String? = nil) -> TextStyle {
                TextStyle(
                    font: Font.customFont(fontName, size: 15, weight: .medium),
                    foregroundColor: foreground
                )
            }
            
        
          
            let font: Font
            let foregroundColor: Color
        }
    }

    // View modifier to apply text styles
    struct StyledText: ViewModifier {
        let style: AppTheme.TextStyle
        
        func body(content: Content) -> some View {
            content
                .font(style.font)
                .foregroundColor(style.foregroundColor)
        }
    }

    // Extension to make it easier to apply text styles
    extension View {
        func textStyle(_ style: AppTheme.TextStyle) -> some View {
            modifier(StyledText(style: style))
        }
    }
