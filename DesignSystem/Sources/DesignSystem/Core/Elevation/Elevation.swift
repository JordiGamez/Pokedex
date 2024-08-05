//
//  Elevation.swift
//  
//  Created by Jordi Gamez on 17/4/24.
//

import Foundation

enum Elevation {

    static var baseShadowOpacity: CGFloat = 0.3
    static var baseShadowRadius: CGFloat = 1

    static func shadowRadius(_ elevation: ElevationModifier.Level) -> CGFloat {
        let radius: CGFloat
        switch elevation {
        case .e1:
            radius = 1
        case .e2:
            radius = 5
        case .e3:
            radius = 12
        case .e4:
            radius = 18
        case .e5:
            radius = 28
        default:
            radius = 0
        }
        return radius
    }

    static func shadowOffset(_ elevation: ElevationModifier.Level) -> (CGFloat, CGFloat) {
        let offset: (CGFloat, CGFloat)
        switch elevation {
        case .e1:
            offset = (0, 1)
        case .e2:
            offset = (0, 3)
        case .e3:
            offset = (0, 8)
        case .e4:
            offset = (0, 10)
        case .e5:
            offset = (0, 18)
        default:
            offset = (0, 0)
        }
        return offset
    }

    static func shadowOpacity(_ elevation: ElevationModifier.Level) -> CGFloat {
        let opacity: CGFloat
        switch elevation {
        case .e1:
            opacity = 0.25
        case .e2:
            opacity = 0.20
        case .e3, .e4, .e5:
            opacity = 0.15
        default:
            opacity = 0
        }
        return opacity
    }
}
