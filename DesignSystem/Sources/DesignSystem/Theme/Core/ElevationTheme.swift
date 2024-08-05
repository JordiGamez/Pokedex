//
//  ElevationTheme.swift
//
//  Created by Jordi Gamez on 26/3/24.
//

import SwiftUI

public protocol ElevationTheme {
    
    var extraLow: ElevationModifier.Level { get }
    var low: ElevationModifier.Level { get }
    var medium: ElevationModifier.Level { get }
    var high: ElevationModifier.Level { get }
    var extraHigh: ElevationModifier.Level { get }
}
