//
//  RadiusTheme.swift
//
//  Created by Jordi Gamez on 27/5/24.
//

import SwiftUI

public protocol RadiusTheme {

    var extraSmall: CGFloat { get }
    var small: CGFloat { get }
    var medium: CGFloat { get }
    var large: CGFloat { get }
    var extraLarge: CGFloat { get }
}
