//
//  DataError.swift
//  Pokedex
//
//  Created by Jordi Gamez on 11/6/24.
//

import Foundation

enum DataError: Error, Equatable {

    case decoding
    case invalidUrl
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case conflict
    case gone
    case server
    case unknown
}
