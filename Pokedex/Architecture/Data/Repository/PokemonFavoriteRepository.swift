//
//  PokemonFavoriteRepository.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import Combine
import ComposableArchitecture
import API

protocol PokemonFavoriteRepositoryProtocol {

    var favoriteChangedPublisher: AnyPublisher<Bool, Never> { get }

    func updatePokemonFavoriteStatus(_ number: Int) async throws -> Bool
    func getPokemonFavoriteStatus(_ number: Int) async throws -> Bool
    func getFavoritePokemonList() async throws -> [PokemonDetailEntity]?
}

extension DependencyValues {

    var pokemonFavoriteRepository: PokemonFavoriteRepositoryProtocol {
        get { self[PokemonFavoriteRepositoryKey.self] }
        set { self[PokemonFavoriteRepositoryKey.self] = newValue }
    }
}

struct PokemonFavoriteRepositoryKey: DependencyKey {

    static var liveValue: PokemonFavoriteRepositoryProtocol = PokemonFavoriteRepository()
    static var testValue: PokemonFavoriteRepositoryProtocol = MockPokemonFavoriteRepository()
}

struct PokemonFavoriteRepository: PokemonFavoriteRepositoryProtocol {

    private var _favoriteChangedPublisher: CurrentValueSubject<Bool, Never>
    public var favoriteChangedPublisher: AnyPublisher<Bool, Never> {
        _favoriteChangedPublisher.eraseToAnyPublisher()
    }

    init(_ favoriteChangedPublisher: Bool = false) {
        _favoriteChangedPublisher = .init(favoriteChangedPublisher)
    }

    func updatePokemonFavoriteStatus(_ number: Int) async throws -> Bool {
        defer {
            _favoriteChangedPublisher.send(true)
        }
        return await PokemonLocalRepository.shared.updatePokemonFavoriteStatus(number: number)
    }

    func getPokemonFavoriteStatus(_ number: Int) async throws -> Bool {
        await PokemonLocalRepository.shared.getPokemonFavoriteStatus(number: number)
    }

    func getFavoritePokemonList() async throws -> [PokemonDetailEntity]? {
        guard let favoritePokemon = await getLocalFavoritePokemonIfAvailable() else {
            return nil
        }
        return PokemonDetailEntityMapper.mapList(favoritePokemon)
    }
}

private extension PokemonFavoriteRepository {

    func getLocalFavoritePokemonIfAvailable() async -> [PokemonDetailModel]? {
        await PokemonLocalRepository.shared.getFavoritePokemonList()
    }
}
