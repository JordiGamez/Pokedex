//
//  PokemonAttributeView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 19/6/24.
//

import SwiftUI
import DesignSystem

struct PokemonAttributeView: View {

    @EnvironmentObject private var theme: ThemeManager

    private let name: String
    private let value: Float

    init(
        name: String,
        value: Float
    ) {
        self.name = name
        self.value = value
    }

    var body: some View {
        VStack(spacing: .zero) {
            attributeTitle
            attributeValue
        }
    }
}

private extension PokemonAttributeView {

    var attributeTitle: some View {
        UIToolkit.text(
            name,
            fontModel: theme.font.caption,
            color: theme.color.textPrimary
        )
        .fontWeight(.semibold)
    }

    var attributeValue: some View {
        UIToolkit.text(
            "\(value)",
            fontModel: theme.font.body,
            color: theme.color.textPrimary
        )
        .fontWeight(.semibold)
    }
}

#Preview {
    PokemonAttributeView(
        name: "Height",
        value: 4
    )
    .environmentObject(ThemeManager.main)
}
