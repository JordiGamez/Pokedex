//
//  SearchReducer.swift
//  Pokedex
//
//  Created by Jordi Gamez on 4/8/24.
//

import ComposableArchitecture

@Reducer
struct SearchReducer {

    @Dependency(\.pokedexRepository) var pokedexRepository

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

        init(
            screen: ScreenState = .loading,
            pokemon: [PokemonInfo] = []
        ) {
            self.screen = screen
            self.pokemon = pokemon
        }
    }

    enum Action: Equatable {
        // Action
        case loadPokedex
        case retryLoadPokedex
        // Feedback
        case pokedexNotFound
        case pokedexEmpty
        case pokedexLoaded([PokemonInfo])
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        // Action

        case .loadPokedex:
            return fetchPokedex(&state)

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
        }
    }
}

private extension SearchReducer {

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
}
