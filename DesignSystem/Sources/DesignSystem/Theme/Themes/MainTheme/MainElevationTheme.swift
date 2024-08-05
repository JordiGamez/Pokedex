//
//  MainElevationTheme.swift
//  
//  Created by Jordi Gamez on 19/4/24.
//

import SwiftUI

struct MainElevationTheme: ElevationTheme {

    var extraLow: ElevationModifier.Level { .e1 }
    var low: ElevationModifier.Level { .e2 }
    var medium: ElevationModifier.Level { .e3 }
    var high: ElevationModifier.Level { .e4 }
    var extraHigh: ElevationModifier.Level { .e5 }
}
