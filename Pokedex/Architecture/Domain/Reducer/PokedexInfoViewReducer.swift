//
//  PokedexInfoViewReducer.swift
//  Pokedex
//
//  Created by Jordi Gamez on 22/4/24.
//

import ComposableArchitecture

@Reducer
struct PokedexInfoViewReducer {

    @Dependency(\.pokemonDetailRepository) var pokemonDetailRepository

    @ObservableState
    struct State: Equatable {
        var pokemonInfo: PokemonInfo
        var pokemonDetail: PokemonDetail?

        init(pokemonInfo: PokemonInfo, pokemonDetail: PokemonDetail? = nil) {
            self.pokemonInfo = pokemonInfo
            self.pokemonDetail = pokemonDetail
        }
    }

    enum Action: Equatable {
        // Action
        case loadPokemon
        // Feedback
        case pokemonDetailNotFound
        case pokemonDetailLoaded(PokemonDetail)
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        // Action

        case .loadPokemon:
            state.pokemonDetail = nil
            return loadPokemonDetail(state.pokemonInfo.number)

        // Feedback

        case .pokemonDetailNotFound:
            state.pokemonDetail = nil
            return .none

        case .pokemonDetailLoaded(let pokemonDetail):
            state.pokemonDetail = pokemonDetail
            return .none
        }
    }
}

private extension PokedexInfoViewReducer {

    func loadPokemonDetail(_ number: Int) -> Effect<Action> {
        .run { send in
            guard let pokemonDetail = try? await pokemonDetailRepository.getPokemonDetail(number) else {
                await send(.pokemonDetailNotFound)
                return
            }
            guard let pokemon = PokemonDetailMapper.map(pokemonDetail) else {
                await send(.pokemonDetailNotFound)
                return
            }
            await send(.pokemonDetailLoaded(pokemon))
        }
    }
}
