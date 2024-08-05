//
//  MockPokemonFavoriteRepository.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import Combine

struct MockPokemonFavoriteRepository: PokemonFavoriteRepositoryProtocol {

    var favoritePokemon: [PokemonDetailEntity]?
    var isFavorite: Bool = false

    private var _favoriteChangedPublisher: CurrentValueSubject<Bool, Never>
    public var favoriteChangedPublisher: AnyPublisher<Bool, Never> {
        _favoriteChangedPublisher.eraseToAnyPublisher()
    }

    init(_ favoriteChangedPublisher: Bool = false) {
        _favoriteChangedPublisher = .init(favoriteChangedPublisher)
    }

    func updatePokemonFavoriteStatus(_ number: Int) async throws -> Bool {
        isFavorite
    }

    func getPokemonFavoriteStatus(_ number: Int) async throws -> Bool {
        isFavorite
    }

    func getFavoritePokemonList() async throws -> [PokemonDetailEntity]? {
        favoritePokemon
    }
}
