//
//  UIGroup.swift
//  PokedexUITests
//
//  Created by Jordi Gamez on 17/5/24.
//

import SwiftUI

protocol UIGroup {

    static var identifier: String { get set }

    static func screenshots(
        _ viewController: UIViewController,
        name: String,
        scheme: ColorScheme
    )
}
