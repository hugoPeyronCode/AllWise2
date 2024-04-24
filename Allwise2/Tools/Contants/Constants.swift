//
//  Constants.swift
//  Allwise2
//
//  Created by Hugo Peyron on 16/04/2024.
//

import Foundation
import SwiftUI

struct SizeConstants {
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var mainProgressBarWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var mainProgressBarHeight: CGFloat {
        UIScreen.main.bounds.height * 0.05
    }
}


struct ColorGradients {
    static let premiumGradient = Gradient(colors: [.green, .blue, .purple, .pink])
    static let premiumLinearGradient =  LinearGradient(gradient: premiumGradient, startPoint: .leading, endPoint: .trailing)
    static let white = LinearGradient(gradient: Gradient(colors: [.white, .white]) , startPoint: .leading, endPoint: .trailing)
}
