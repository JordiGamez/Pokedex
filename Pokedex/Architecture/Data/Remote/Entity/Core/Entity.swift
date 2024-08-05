//
//  Entity.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

protocol Entity: Codable, Hashable {
    
    static func empty() -> Self
    static func mock() -> Self
}
