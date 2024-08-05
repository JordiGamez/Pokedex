//
//  PrimaryButtonStyle.swift
//
//  Created by Jordi Gamez on 12/6/24.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {

    @Environment(\.isFocused) var focused: Bool

    @EnvironmentObject var theme: ThemeManager
    
    @State private var backgroundColor: Color = .clear

    private static let defaultBackgroundColor: Color = .clear
    private static let focusedBackgroundColor: Color = .white
    private static let padding: CGFloat = 4

    public init() {
        // Intentionally empty
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, theme.spacing.medium)
            .padding(.horizontal, theme.spacing.large)
            .background(theme.color.actionTextPrimary)
            .onChange(of: focused, { oldValue, newValue in
                withAnimation(.linear(duration: 0.2)) {
                    backgroundColor = newValue ? Self.focusedBackgroundColor : theme.color.actionBackgroundPrimary
                }
            })
            .cornerRadius(theme.spacing.large)
    }
}
