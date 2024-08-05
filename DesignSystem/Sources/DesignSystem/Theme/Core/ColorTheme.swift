//
//  ColorTheme.swift
//  
//  Created by Jordi Gamez on 27/5/24.
//

import SwiftUI

public protocol ColorTheme {

    // Text
    var textPrimary: Color { get }
    var textSecondary: Color { get }

    // Background
    var backgroundPrimary: Color { get }
    var backgroundSecondary: Color { get }

    // Action
    var actionTextPrimary: Color { get }
    var actionBackgroundPrimary: Color { get }
}
