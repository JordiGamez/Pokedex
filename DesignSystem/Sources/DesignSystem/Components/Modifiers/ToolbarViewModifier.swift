//
//  ToolbarViewModifier.swift
//
//  Created by Jordi Gamez on 12/6/24.
//

import SwiftUI
import DesignSystem

public extension View {

    func toolbarStyle() -> some View {
        modifier(ToolbarDefaultViewModifier())
    }
}

struct ToolbarDefaultViewModifier: ViewModifier {

    @EnvironmentObject private var theme: ThemeManager

    func body(content: Content) -> some View {
        content
            .toolbarBackground(theme.color.backgroundSecondary, for: .navigationBar)
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationTitle("")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .navigationViewStyle(.stack)
            .navigationBarBackButtonHidden()
    }
}
