//
//  Color+Extension.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 30.09.2023.
//

import SwiftUI

struct Palette {
    let _50: Color
    let _100: Color
    let _200: Color
    let _300: Color
    let _400: Color
    let _500: Color
    let _600: Color
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
    let splashBGColor = Color("splashBG")
    let miamiHeatRed = Color("miami_heat_red")
}

extension Color {
    
    static let theme = ColorTheme()
    
    static var blue: Palette {
        Palette(
            _50: Color("Blue50"),
            _100: Color("Blue100"),
            _200: Color("Blue200"),
            _300: Color("Blue300"),
            _400: Color("Blue400"),
            _500: Color("Blue500"),
            _600: Color("Blue600")
        )
    }
    
    static var indigo: Palette {
        Palette(
            _50: Color("Indigo50"),
            _100: Color("Indigo100"),
            _200: Color("Indigo200"),
            _300: Color("Indigo300"),
            _400: Color("Indigo400"),
            _500: Color("Indigo500"),
            _600: Color("Indigo600")
        )
    }
    
    static var orange: Palette {
        Palette(
            _50: Color("Orange50"),
            _100: Color("Orange100"),
            _200: Color("Orange200"),
            _300: Color("Orange300"),
            _400: Color("Orange400"),
            _500: Color("Orange500"),
            _600: Color("Orange600")
        )
    }
    
    static var rose: Palette {
        Palette(
            _50: Color("Rose50"),
            _100: Color("Rose100"),
            _200: Color("Rose200"),
            _300: Color("Rose300"),
            _400: Color("Rose400"),
            _500: Color("Rose500"),
            _600: Color("Rose600")
        )
    }
    
    static var sky: Palette {
        Palette(
            _50: Color("Sky50"),
            _100: Color("Sky100"),
            _200: Color("Sky200"),
            _300: Color("Sky300"),
            _400: Color("Sky400"),
            _500: Color("Sky500"),
            _600: Color("Sky600")
        )
    }
    
    static var sun: Color {
        Color("sun-text")
    }
    
    static var greenText: Color {
        Color("green-text")
    }
    
    static var bannerBG: Color {
        Color("banner-bg")
    }
    
    static var yellow: Palette {
        Palette(
            _50: Color("Yellow50"),
            _100: Color("Yellow100"),
            _200: Color("Yellow200"),
            _300: Color("Yellow300"),
            _400: Color("Yellow400"),
            _500: Color("Yellow500"),
            _600: Color("Yellow600")
        )
    }
    
    static var pink: Palette {
        Palette(
            _50: Color("Pink50"),
            _100: Color("Pink100"),
            _200: Color("Pink200"),
            _300: Color("Pink300"),
            _400: Color("Pink400"),
            _500: Color("Pink500"),
            _600: Color("Pink600")
        )
    }
}


