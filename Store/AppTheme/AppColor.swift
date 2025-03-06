//
//  AppColor.swift
//  Store
//
//  Created by Don Arias Agokoli on 23/12/2024.
//
import SwiftUI
struct AppColors {
    
    static let primary = Color(hex: "67C4A7")
    
    // Grays (Dark to Light)
    static let primary900 = Color(hex: 0x1A1A1A)
    static let primary800 = Color(hex: 0x333333)
    static let primary700 = Color(hex: 0x4D4D4D)
    
    // Primary Grays (Highlighted in blue in the design)
    static let primary600 = Color(hex: 0x666666)
    static let primary500 = Color(hex: 0x808080)
    static let primary400 = Color(hex: 0x999999)
    
    // Light Grays
    static let primary300 = Color(hex: 0xB3B3B3)
    static let primary200 = Color(hex: 0xCCCCCC)
    static let primary100 = Color(hex: 0xE6E6E6)
    static let white = Color(hex: 0xFFFFFF)
    
    // Accent Colors
    static let success = Color(hex: 0x0C9409)  // Green
    static let error = Color(hex: 0xED1010)  // Red
}

// Extension to create colors from hex values
extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&int)
        
        let r = Double((int & 0xFF0000) >> 16) / 255.0
        let g = Double((int & 0x00FF00) >> 8) / 255.0
        let b = Double(int & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
