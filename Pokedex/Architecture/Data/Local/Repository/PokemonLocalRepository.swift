//
//  PokemonLocalRepository.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import SwiftUI
import SwiftData

@MainActor
final class PokemonLocalRepository {

    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = PokemonLocalRepository()

    @MainActor
    init() {
        modelContainer = try! ModelContainer(
            for: PokemonInfoModel.self,
            PokemonDetailModel.self,
            FavoritePokemonList.self
        )
        modelContext = modelContainer.mainContext
    }
}

// MARK: - Pokedex

extension PokemonLocalRepository {

    func fetchPokedex() -> [PokemonInfoModel]? {
        do {
            let pokemon = try modelContext.fetch(FetchDescriptor<PokemonInfoModel>())
            return pokemon.count > .zero ? pokemon : nil
        } catch {
            return nil
        }
    }

    func appendPokemon(pokemon: PokemonInfoModel) {
        defer { try? modelContext.save() }
        modelContext.insert(pokemon)
    }
    
    func removePokemon(pokemon: PokemonInfoModel) {
        modelContext.delete(pokemon)
    }
}

// MARK: - PokemonDetail

extension PokemonLocalRepository {

    func fetchAllPokemonDetail() -> [PokemonDetailModel]? {
        do {
            let pokemon = try modelContext.fetch(FetchDescriptor<PokemonDetailModel>())
            return pokemon.count > .zero ? pokemon : nil
        } catch {
            return nil
        }
    }

    func fetchPokemonDetail(number: Int) -> [PokemonDetailModel]? {
        let predicate = #Predicate<PokemonDetailModel> { $0.number == number }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        do {
            let pokemonDetail = try modelContext.fetch(fetchDescriptor)
            return pokemonDetail.count > .zero ? pokemonDetail : nil
        } catch {
            return nil
        }
    }

    func appendPokemonDetail(pokemonDetail: PokemonDetailModel) {
        defer { try? modelContext.save() }
        modelContext.insert(pokemonDetail)
    }

    func removePokemonDetail(pokemonDetail: PokemonDetailModel) {
        modelContext.delete(pokemonDetail)
    }
}

// MARK: - FavoritePokemon

extension PokemonLocalRepository {

    func getFavoritePokemonList() -> [PokemonDetailModel]? {
        do {
            let pokemonList = try modelContext.fetch(FetchDescriptor<PokemonDetailModel>())
            let favoritePokemonList = try modelContext.fetch(FetchDescriptor<FavoritePokemonList>())

            let favoritePokemonListNumbers = Set(favoritePokemonList.map { $0.number })
            var pokemon = pokemonList.filter { favoritePokemonListNumbers.contains($0.number) }
            pokemon.sort(by: { $0.number < $1.number })

            return pokemon
        } catch {
            return nil
        }
    }

    func getPokemonFavoriteStatus(number: Int) -> Bool {
        let predicate = #Predicate<FavoritePokemonList> { $0.number == number }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        do {
            return try modelContext.fetch(fetchDescriptor).first != nil
        } catch {
            return false
        }
    }

    func updatePokemonFavoriteStatus(number: Int) -> Bool {
        let predicate = #Predicate<FavoritePokemonList> { $0.number == number }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        do {
            if let pokemon = try modelContext.fetch(fetchDescriptor).first {
                removePokemonFromFavorite(pokemon: pokemon)
                return false
            }
            return addPokemonToFavorite(number: number)
        } catch {
            return false
        }
    }

    private func addPokemonToFavorite(number: Int) -> Bool {
        let model = FavoritePokemonList(number: number)
        modelContext.insert(model)
        do {
            try modelContext.save()
            return true
        } catch {
            return false
        }
    }

    private func removePokemonFromFavorite(pokemon: FavoritePokemonList) {
        modelContext.delete(pokemon)
    }
}
