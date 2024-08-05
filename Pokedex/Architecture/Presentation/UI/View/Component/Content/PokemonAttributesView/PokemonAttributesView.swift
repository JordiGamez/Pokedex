//
//  PokemonAttributesView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 19/6/24.
//

import SwiftUI
import DesignSystem

struct PokemonAttributesView: View {

    @EnvironmentObject private var theme: ThemeManager

    private let height: Float
    private let weight: Float

    init(
        height: Float,
        weight: Float
    ) {
        self.height = height
        self.weight = weight
    }

    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            Spacer()
            attributeHeight
            Spacer()
            attributeWeight
            Spacer()
        }
    }
}

private extension PokemonAttributesView {

    var attributeHeight: some View {
        PokemonAttributeView(name: "Height", value: height)
    }

    var attributeWeight: some View {
        PokemonAttributeView(name: "Weight", value: weight)
    }
}

#Preview {
    PokemonAttributesView(
        height: 4,
        weight: 60
    )
    .environmentObject(ThemeManager.main)
}
