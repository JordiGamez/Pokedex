//
//  MainColorTheme.swift
//
//  Created by Jordi Gamez on 26/3/24.
//

import SwiftUI

struct MainColorTheme: ColorTheme {

    // Text
    var textPrimary: Color { .customBlack }
    var textSecondary: Color { .customWhite }

    // Background
    var backgroundPrimary: Color { .customGrey }
    var backgroundSecondary: Color { .customWhite }

    // Action
    var actionTextPrimary: Color { .customDarkGrey }
    var actionBackgroundPrimary: Color { .customGrey }
}
