//
//  UITheme.swift
//  PokedexUITests
//
//  Created by Jordi Gamez on 17/5/24.
//

import UIKit
import SnapshotTesting

extension ViewImageConfig {
    static let iPhone15ProMax = ViewImageConfig(
        safeArea: .init(top: 59, left: 0, bottom: 34, right: 0), // Update with actual insets if known
        size: .init(width: 430, height: 932) // Update with actual dimensions if known
    )
}

enum UITheme {

    enum Devices {
        static var list: [String: ViewImageConfig] = ["iPhone15ProMax": .iPhone15ProMax]
    }
}
