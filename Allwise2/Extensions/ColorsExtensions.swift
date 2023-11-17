//
//  ColorsExtensions.swift
//  Allwise2
//
//  Created by Hugo Peyron on 17/11/2023.
//

import Foundation
import SwiftUI
import UIKit

extension Color {
    var dark: Color {
        // Convert the SwiftUI Color to a UIColor
        let uiColor = UIColor(self)

        // Get the HSB components of the color
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        // Reduce the brightness
        brightness *= 0.8 // Adjust this value as needed

        // Return the darkened color as a SwiftUI Color
        return Color(hue: Double(hue), saturation: Double(saturation), brightness: Double(brightness), opacity: Double(alpha))
    }
}
