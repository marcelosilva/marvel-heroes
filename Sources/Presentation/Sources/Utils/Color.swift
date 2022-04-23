//
//  Color.swift
//  
//
//  Created by Marcelo Silva on 22/4/22.
//


import SwiftUI

public extension Color {
    static let marvelYellow = Color(Asset.marvelColorYellow.color)
    static let marvelBlue = Color(Asset.marvelColorBlue.color)
    static let marvelPink = Color(Asset.marvelColorPink.color)
    static let marvelGreen = Color(Asset.marvelColorGreen.color)
    static let marvelRed = Color(Asset.marvelColorRed.color)
    
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
