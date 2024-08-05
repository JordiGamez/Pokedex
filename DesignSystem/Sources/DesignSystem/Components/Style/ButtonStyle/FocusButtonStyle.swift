//
//  FocusButtonStyle.swift
//
//  Created by Jordi Gamez on 17/5/24.
//

import SwiftUI

public struct FocusButtonStyle: ButtonStyle {

    @Environment(\.isFocused) var focused: Bool

    @State private var backgroundColor: Color = .clear

    private static let defaultBackgroundColor: Color = .clear
    private static let focusedBackgroundColor: Color = .white
    private static let padding: CGFloat = 4

    public init() {
        // Intentionally empty
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(Self.padding)
            .background(backgroundColor)
            .onChange(of: focused, { oldValue, newValue in
                withAnimation(.linear(duration: 0.2)) {
                    backgroundColor = newValue ? Self.focusedBackgroundColor : Self.defaultBackgroundColor
                }
            })
    }
}
