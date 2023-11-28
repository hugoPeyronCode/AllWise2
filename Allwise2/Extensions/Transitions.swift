//
//  Transitions.swift
//  Allwise2
//
//  Created by Hugo Peyron on 25/11/2023.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var slide: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
        let removal = AnyTransition.move(edge: .leading)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
