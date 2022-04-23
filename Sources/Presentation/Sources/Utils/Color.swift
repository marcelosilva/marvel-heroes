//
//  Color.swift
//  
//
//  Created by Marcelo Silva on 22/4/22.
//


import SwiftUI

public extension Color {
    static let marvelYellow = Color(Asset.Colors.marvelColorYellow.color)
    static let marvelBlue = Color(Asset.Colors.marvelColorBlue.color)
    static let marvelPink = Color(Asset.Colors.marvelColorPink.color)
    static let marvelGreen = Color(Asset.Colors.marvelColorGreen.color)
    static let marvelRed = Color(Asset.Colors.marvelColorRed.color)
    
    static func randomColorByIndex(index: Int) -> Color {
        let colorIndex = index % 4
        if colorIndex == 0 {
            return marvelYellow
        }
        if colorIndex == 1 {
            return marvelBlue
        }
        if colorIndex == 2 {
            return marvelPink
        }
        return marvelGreen
    }
    
}
