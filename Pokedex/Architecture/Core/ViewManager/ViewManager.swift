//
//  ViewManager.swift
//  Pokedex
//
//  Created by Jordi Gamez on 8/6/24.
//

import SwiftUI

struct ViewManager {

    static func pokemonDetailPage(pokemonInfo: PokemonInfo) -> some View {
        PokemonDetailPage(
            store: StoreManager.pokemonDetailStore(
                pokemonInfo: pokemonInfo
            ),
            pokemonInfo: pokemonInfo
        )
    }

    static func pokemonInfoView(pokemonInfo: PokemonInfo) -> some View {
        PokemonInfoView(
            store: StoreManager.pokemonInfoStore(
                pokemonInfo: pokemonInfo
            ),
            pokemonInfo: pokemonInfo
        )
    }

    static func favoritePokemonPage() -> some View {
        FavoritePokemonPage(
            store: StoreManager.favoritePokemonStore()
        )
    }

    static func pokemonExtendedInfoView(pokemonDetail: PokemonDetail) -> some View {
        PokemonExtendedInfoView(
            pokemonDetail: pokemonDetail
        )
    }

    static func pokemonSearchView(pokemonInfo: PokemonInfo) -> some View {
        PokemonSearchView(
            pokemonInfo: pokemonInfo
        )
    }
}
