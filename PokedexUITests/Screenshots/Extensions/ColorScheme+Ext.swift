//
//  ColorScheme+Ext.swift
//  PokedexUITests
//
//  Created by Jordi Gamez on 17/5/24.
//

import SwiftUI

extension ColorScheme {

    var interfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        @unknown default:
             return .unspecified
        }
    }
}
