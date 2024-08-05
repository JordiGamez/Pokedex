//
//  StringProtocol+Ext.swift
//  Pokedex
//
//  Created by Jordi Gamez on 17/4/24.
//

import Foundation

public extension String {

    var firstUppercased: String {
        prefix(1).uppercased() + dropFirst()
    }
}
