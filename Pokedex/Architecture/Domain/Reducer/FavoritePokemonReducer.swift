//
//  FavoritePokemonReducer.swift
//  Pokedex
//
//  Created by Jordi Gamez on 14/5/24.
//

import ComposableArchitecture
import Combine
import Foundation

@Reducer
struct FavoritePokemonReducer {

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
        var pokemon: [PokemonDetail]
        var shouldReload: Bool = false

        init(
            screen: ScreenState = .loading,
            pokemon: [PokemonDetail] = []
        ) {
            self.screen = screen
            self.pokemon = pokemon
        }
    }

    enum Action: Equatable {
        // Action
        case loadPokemon
        case retryLoadFavoritePokemon
        case listenForFavoriteChanges
        case reloadIfNeeded
        // Feedback
        case emptyFavoriteList
        case favoriteListLoaded([PokemonDetail])
        case reloadList
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        // Action

        case .loadPokemon:
            return loadFavoritePokemon()

        case .listenForFavoriteChanges:
            return listenToReloadList()

        case .retryLoadFavoritePokemon:
            state.screen = .loading
            return loadFavoritePokemon()
            
        case .reloadIfNeeded:
            if state.shouldReload {
                state.screen = .loading
                state.pokemon = []
                state.shouldReload = false
                return loadFavoritePokemon()
            }
            return .none

        // Feedback

        case .emptyFavoriteList:
            state.screen = .empty
            state.pokemon = []
            return .none

        case .favoriteListLoaded(let pokemon):
            state.screen = .content
            state.pokemon = pokemon
            return .none

        case .reloadList:
            state.screen = .loading
            state.pokemon = []
            state.shouldReload = true
            return .none
        }
    }
}

private extension FavoritePokemonReducer {

    func loadFavoritePokemon() -> Effect<Action> {
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

    func listenToReloadList() -> Effect<Action> {
        Effect
            .publisher {
                pokemonFavoriteRepository
                    .favoriteChangedPublisher
                    .dropFirst()
                    .receive(on: DispatchQueue.main)
            }
            .map { _ in .reloadList }
    }
}
