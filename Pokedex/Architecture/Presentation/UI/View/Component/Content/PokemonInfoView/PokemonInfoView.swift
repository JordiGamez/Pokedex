//
//  PokemonInfoView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 17/4/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct PokemonInfoView: View {

    @Environment(\.layoutDisplayType) private var layoutDisplayType

    @EnvironmentObject private var theme: ThemeManager
    
    private static let itemPokemonImageSize: CGFloat = 150

    private let store: StoreOf<PokedexInfoViewReducer>
    private let pokemonInfo: PokemonInfo

    init(store: StoreOf<PokedexInfoViewReducer>, pokemonInfo: PokemonInfo) {
        self.store = store
        self.pokemonInfo = pokemonInfo
    }

    var body: some View {
        infoView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, theme.spacing.medium)
            .background(theme.color.backgroundSecondary)
            .onFirstAppear {
                store.send(.loadPokemon)
            }
    }
}

private extension PokemonInfoView {

    var infoView: some View {
        VStack(alignment: .leading) {
            pokemonImage
            pokemonName
            pokemonNumber
        }
    }

    var pokemonImage: some View {
        ZStack(alignment: .topLeading) {
            pokemonBackgroundColor
            pokemonPicture
        }
        .clipped()
    }

    var pokemonBackgroundColor: some View {
        store.state.pokemonDetail?.typeColor
    }

    var pokemonPicture: some View {
        HStack {
            Spacer()
            UIToolkit.asyncImage(
                pokemonInfo.imageURL,
                size: Self.itemPokemonImageSize,
                placeholderImage: .loading
            )
            .padding(theme.spacing.medium)
            Spacer()
        }
    }

    var pokemonName: some View {
        UIToolkit.text(
            pokemonInfo.name.uppercased(),
            fontModel: theme.font.body,
            color: theme.color.textPrimary
        )
        .fontWeight(.bold)
        .multilineTextAlignment(.leading)
        .padding(.horizontal, theme.spacing.medium)
    }

    var pokemonNumber: some View {
        UIToolkit.text(
            "#\(pokemonInfo.numberFormatted)",
            fontModel: theme.font.caption,
            color: theme.color.textPrimary
        )
        .fontWeight(.semibold)
        .padding(.horizontal, theme.spacing.medium)
    }
}

#Preview {
    PokemonInfoView(
        store: .init(initialState: .init(pokemonInfo: .mock())) { PokedexInfoViewReducer() },
        pokemonInfo: .mock()
    )
}
