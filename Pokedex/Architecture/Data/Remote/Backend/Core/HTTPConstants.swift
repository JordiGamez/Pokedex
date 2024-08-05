//
//  HTTPConstants.swift
//  Pokedex
//
//  Created by Jordi Gamez on 11/6/24.
//

import Foundation

enum HTTPConstants {

    private static var baseURL: String = BackendEnvironment.pro.url

    static var v2BaseURL: String {
        baseURL + "api/"
    }
}
