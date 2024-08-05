//
//  PokemonSearchView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 4/8/24.
//

import SwiftUI
import DesignSystem

struct PokemonSearchView: View {

    @EnvironmentObject private var theme: ThemeManager

    private static let containerHeight: CGFloat = 50

    private let pokemonInfo: PokemonInfo

    init(pokemonInfo: PokemonInfo) {
        self.pokemonInfo = pokemonInfo
    }

    var body: some View {
        HStack(alignment: .center, spacing: theme.spacing.large) {
            pokemonNumber
            pokemonName
            Spacer()
            pokemonImage
        }
        .frame(maxWidth: .infinity, maxHeight: Self.containerHeight, alignment: .leading)
        .background(theme.color.backgroundSecondary)
    }
}

private extension PokemonSearchView {

    var pokemonNumber: some View {
        UIToolkit.text(
            "#\(pokemonInfo.numberFormatted)",
            fontModel: theme.font.caption,
            color: theme.color.textPrimary
        )
        .fontWeight(.semibold)
        .padding(.leading, theme.spacing.large)
    }

    var pokemonName: some View {
        UIToolkit.text(
            pokemonInfo.name.uppercased(),
            fontModel: theme.font.body,
            color: theme.color.textPrimary
        )
        .fontWeight(.bold)
        .multilineTextAlignment(.leading)
    }

    var pokemonImage: some View {
        UIToolkit.asyncImage(
            pokemonInfo.imageURL,
            size: Self.containerHeight,
            placeholderImage: .loading
        )
        .padding(.trailing, theme.spacing.large)
        .padding(.vertical, theme.spacing.extraSmall)
    }
}

#Preview {
    PokemonSearchView(
        pokemonInfo: .mock()
    )
}
