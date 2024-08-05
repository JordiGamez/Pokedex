//
//  LayoutDisplay.swift
//
//  Created by Jordi Gamez on 13/5/24.
//

import SwiftUI

public struct LayoutDisplay: EnvironmentKey {

    public static let defaultValue: LayoutDisplayType = .defaultLayout
}

public extension EnvironmentValues {

    var layoutDisplayType: LayoutDisplayType {
        get { self[LayoutDisplay.self] }
        set { self[LayoutDisplay.self] = newValue }
    }
}

public enum LayoutDisplayType {

    case compact
    case regular
    case tv
    case mac

    static var defaultLayout: Self {
        #if os(macOS)
        return .mac
        #elseif os(tvOS)
        return .tv
        #else
        switch UIScreen.main.traitCollection.horizontalSizeClass {
        case .compact:
            return .compact
        case .regular:
            return .regular
        default:
            return .regular
        }
        #endif
    }
}
