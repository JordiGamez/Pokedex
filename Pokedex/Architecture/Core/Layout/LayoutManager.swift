//
//  LayoutManager.swift
//  Pokedex
//
//  Created by Jordi Gamez on 8/6/24.
//

import SwiftUI
import DesignSystem

struct LayoutManager {

    static var blogGridLayout: [GridItem] {
        switch LayoutDisplay.defaultValue {
        case .compact:
            return .grid(2)
        case .regular:
            return .grid(4)
        case .tv:
            return .grid(5)
        case .mac:
            return .grid(6)
        }
    }

    static var favoriteGridLayout: Int {
        switch LayoutDisplay.defaultValue {
        case .compact:
            return 1
        case .regular:
            return 2
        case .tv:
            return 2
        case .mac:
            return 2
        }
    }

    static var searchGridLayout: [GridItem] {
        switch LayoutDisplay.defaultValue {
        case .compact:
            return .grid(1)
        case .regular:
            return .grid(2)
        case .tv:
            return .grid(3)
        case .mac:
            return .grid(3)
        }
    }
}
