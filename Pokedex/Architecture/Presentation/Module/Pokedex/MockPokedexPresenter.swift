//
//  MockPokedexPresenter.swift
//  Pokedex
//
//  Created by Jordi Gámez on 16/10/23.
//

import Foundation

final class MockPokedexPresenter: PokedexPresenter {
    
    var screenState: PokedexScreenState = .content
    var pokemonList: PokemonViewModel = .empty()
    
    init(pokemonList: [Pokemon]) {
        self.pokemonList = PokemonViewModelMapper.map(pokemonList)
    }
    
    func loadPokemon() {
        // Intentionally empty
    }
    
    func loadPokemonDetail(id: String) {
        // Intentionally empty
    }
}
