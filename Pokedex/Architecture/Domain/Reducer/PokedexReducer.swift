//
//  PokedexReducer.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import ComposableArchitecture

@Reducer
struct PokedexReducer {

    @Dependency(\.pokedexRepository) var pokedexRepository
    @Dependency(\.pokemonFavoriteRepository) var pokemonFavoriteRepository

    enum ScreenState {
        case loading
        case empty
        case error
        case content
    }

    @ObservableState
    struct State: Equatable {
        var screen: ScreenState
        var pokemon: [PokemonInfo] = []
        var favoritePokemon: [PokemonDetail] = []

        init(
            screen: ScreenState = .loading,
            pokemon: [PokemonInfo] = [],
            favoritePokemon: [PokemonDetail] = []
        ) {
            self.screen = screen
            self.pokemon = pokemon
            self.favoritePokemon = favoritePokemon
        }
    }

    enum Action: Equatable {
        // Action
        case loadPokedex
        case loadFavoritePokemon
        case retryLoadPokedex
        // Feedback
        case pokedexNotFound
        case pokedexEmpty
        case pokedexLoaded([PokemonInfo])
        case emptyFavoriteList
        case favoriteListLoaded([PokemonDetail])
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        // Action

        case .loadPokedex:
            return fetchPokedex(&state)

        case .loadFavoritePokemon:
            return fetchFavoritePokemon(&state)

        case .retryLoadPokedex:
            return fetchPokedex(&state)

        // Feedback

        case .pokedexNotFound:
            state.screen = .error
            state.pokemon = []
            return .none
        
        case .pokedexEmpty:
            state.screen = .empty
            state.pokemon = []
            return .none

        case .pokedexLoaded(let pokemon):
            state.screen = .content
            state.pokemon = pokemon
            return .none

        case .emptyFavoriteList:
            state.favoritePokemon = []
            return .none

        case .favoriteListLoaded(let pokemon):
            state.favoritePokemon = pokemon
            return .none
        }
    }
}

private extension PokedexReducer {

    func fetchPokedex(_ state: inout State) -> Effect<Action> {
        .run { send in
            guard let pokedex = try? await pokedexRepository.getPokedex() else {
                await send(.pokedexNotFound)
                return
            }
            let pokemon = PokemonInfoMapper.mapList(pokedex.pokemon)
            guard pokemon.count > .zero else {
                await send(.pokedexEmpty)
                return
            }
            await send(.pokedexLoaded(pokemon))
        }
    }

    func fetchFavoritePokemon(_ state: inout State) -> Effect<Action> {
        .run { send in
            guard let favoritePokemon = try? await pokemonFavoriteRepository.getFavoritePokemonList() else {
                await send(.emptyFavoriteList)
                return
            }
            let pokemon = PokemonDetailMapper.mapList(favoritePokemon)
            guard pokemon.count > .zero else {
                await send(.emptyFavoriteList)
                return
            }
            await send(.favoriteListLoaded(pokemon))
        }
    }
}
