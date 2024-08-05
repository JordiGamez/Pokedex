//
//  PokemonDetailReducer.swift
//  Pokedex
//
//  Created by Jordi Gamez on 4/5/24.
//

import ComposableArchitecture

@Reducer
struct PokemonDetailReducer {

    @Dependency(\.pokemonDetailRepository) var pokemonDetailRepository
    @Dependency(\.pokemonFavoriteRepository) var pokemonFavoriteRepository

    @ObservableState
    struct State: Equatable {
        var pokemonInfo: PokemonInfo?
        var pokemonDetail: PokemonDetail?
        var isFavorite: Bool

        init(
            pokemonInfo: PokemonInfo? = nil,
            pokemonDetail: PokemonDetail? = nil,
            isFavorite: Bool = false
        ) {
            self.pokemonInfo = pokemonInfo
            self.pokemonDetail = pokemonDetail
            self.isFavorite = isFavorite
        }
    }

    enum Action: Equatable {
        // Action
        case loadPokemonDetail
        case favorite
        // Feedback
        case pokemonDetailNotFound
        case pokemonDetailLoaded(PokemonDetail)
        case pokemonFavoriteStatusChanged(Bool)
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        // Action

        case .loadPokemonDetail:
            guard state.pokemonDetail == nil else {
                return .none
            }
            return loadPokemonDetail(&state)

        case .favorite:
            return updatePokemonFavoriteStatus(&state)

        // Feedback

        case .pokemonDetailNotFound:
            state.pokemonDetail = nil
            return .none

        case .pokemonDetailLoaded(let pokemonDetail):
            state.pokemonDetail = pokemonDetail
            return .none

        case .pokemonFavoriteStatusChanged(let isFavorite):
            state.isFavorite = isFavorite
            return .none
        }
    }
}

private extension PokemonDetailReducer {

    func loadPokemonDetail(_ state: inout State) -> Effect<Action> {
        guard let pokemonInfo = state.pokemonInfo else {
            return .none
        }
        return .run { send in
            guard let pokemonDetail = try? await pokemonDetailRepository.getPokemonDetail(pokemonInfo.number) else {
                await send(.pokemonDetailNotFound)
                return
            }
            guard let pokemon = PokemonDetailMapper.map(pokemonDetail) else {
                await send(.pokemonDetailNotFound)
                return
            }
            await send(.pokemonDetailLoaded(pokemon))

            let isFavorite = try? await pokemonFavoriteRepository.getPokemonFavoriteStatus(pokemonInfo.number)
            await send(.pokemonFavoriteStatusChanged(isFavorite ?? false))
        }
    }

    func updatePokemonFavoriteStatus(_ state: inout State) -> Effect<Action> {
        guard let pokemonInfo = state.pokemonInfo else {
            return .none
        }
        return .run { send in
            let isFavorite = try? await pokemonFavoriteRepository.updatePokemonFavoriteStatus(pokemonInfo.number)
            await send(.pokemonFavoriteStatusChanged(isFavorite ?? false))
        }
    }
}
