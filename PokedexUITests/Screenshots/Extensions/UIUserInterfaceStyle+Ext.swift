//
//  UIUserInterfaceStyle+Ext.swift
//  PokedexUITests
//
//  Created by Jordi Gamez on 17/5/24.
//

import UIKit

extension UIUserInterfaceStyle {

    var name: String {
        switch self {
        case .light:
            return "light"
        case .dark:
            return "dark"
        case .unspecified:
            return ""
        @unknown default:
            return ""
        }
    }
}
