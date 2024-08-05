//
//  ThemeManager.swift
//
//  Created by Jordi Gamez on 26/3/24.
//

import SwiftUI

public class ThemeManager: ObservableObject {

    @Published public var color: ColorTheme = MainColorTheme()
    @Published public var font: FontTheme = MainFontTheme()
    @Published public var spacing: SpacingTheme = MainSpacingTheme()
    @Published public var radius: RadiusTheme = MainRadiusTheme()
    @Published public var elevation: ElevationTheme = MainElevationTheme()

    init(
        color: ColorTheme,
        font: FontTheme,
        spacing: SpacingTheme,
        radius: RadiusTheme,
        elevation: ElevationTheme
    ) {
        self.color = color
        self.font = font
        self.spacing = spacing
        self.radius = radius
        self.elevation = elevation
    }
}

public extension ThemeManager {
    
    static var main: ThemeManager {
        .init(
            color: MainColorTheme(),
            font: MainFontTheme(),
            spacing: MainSpacingTheme(),
            radius: MainRadiusTheme(),
            elevation: MainElevationTheme()
        )
    }
}
