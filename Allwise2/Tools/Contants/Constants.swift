//
//  Constants.swift
//  Allwise2
//
//  Created by Hugo Peyron on 16/04/2024.
//

import Foundation
import SwiftUI

struct SizeConstants {
    static var height: CGFloat {
        UIScreen.main.bounds.height
    }
    static var width: CGFloat {
        UIScreen.main.bounds.width
    }
}

struct ColorGradients {
    static let premiumGradient = Gradient(colors: [.green, .blue, .purple, .pink])
    static let premiumLinearGradient =  LinearGradient(gradient: premiumGradient, startPoint: .leading, endPoint: .trailing)
    static let white = LinearGradient(gradient: Gradient(colors: [.white, .white]) , startPoint: .leading, endPoint: .trailing)
}
