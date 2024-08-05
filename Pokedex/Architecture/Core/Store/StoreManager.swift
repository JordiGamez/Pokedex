//
//  StoreManager.swift
//  Pokedex
//
//  Created by Jordi Gamez on 8/6/24.
//

import ComposableArchitecture

struct StoreManager {

    static func pokedexStore() -> Store<PokedexReducer.State, PokedexReducer.Action> {
        Store(initialState: PokedexReducer.State(pokemon: [])) {
            PokedexReducer()
        }
    }

    static func favoritePokemonStore() -> Store<FavoritePokemonReducer.State, FavoritePokemonReducer.Action> {
        Store(initialState: FavoritePokemonReducer.State(screen: .loading)) {
            FavoritePokemonReducer()
        }
    }

    static func pokemonDetailStore(pokemonInfo: PokemonInfo) -> Store<PokemonDetailReducer.State, PokemonDetailReducer.Action> {
        Store(initialState: PokemonDetailReducer.State(pokemonInfo: pokemonInfo)) {
            PokemonDetailReducer()
        }
    }

    static func pokemonInfoStore(pokemonInfo: PokemonInfo) -> Store<PokedexInfoViewReducer.State, PokedexInfoViewReducer.Action> {
        Store(initialState: PokedexInfoViewReducer.State(pokemonInfo: pokemonInfo)) {
            PokedexInfoViewReducer()
        }
    }

    static func searchStore() -> Store<SearchReducer.State, SearchReducer.Action> {
        Store(initialState: SearchReducer.State(pokemon: [])) {
            SearchReducer()
        }
    }
}
