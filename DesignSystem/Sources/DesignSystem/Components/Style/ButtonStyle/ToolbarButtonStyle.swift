//
//  ToolbarButtonStyle.swift
//
//  Created by Jordi Gamez on 12/6/24.
//

import SwiftUI

public struct ToolbarButtonStyle: ButtonStyle {

    @Environment(\.isFocused) var focused: Bool
    
    @EnvironmentObject var theme: ThemeManager

    public init() {
        // Intentionally empty
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(theme.color.actionTextPrimary)
    }
}
