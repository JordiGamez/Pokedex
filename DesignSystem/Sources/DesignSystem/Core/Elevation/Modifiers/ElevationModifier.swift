//
//  ElevationModifier.swift
//  
//  Created by Jordi Gamez on 17/4/24.
//

import SwiftUI

public extension View {
    /// Visual effect that adds depth and hierarchy to UI elements, based on drop shadows.
    /// - Parameter level: The visual level of "depth" for the element.
    /// - Returns: A View with the ``ElevationModifier`` applied.
    func elevation(_ level: ElevationModifier.Level) -> some View {
        modifier(ElevationModifier(level: level))
    }
}

/// Visual effect that adds depth and hierarchy to UI elements, based on drop shadows.
public struct ElevationModifier: ViewModifier {
    public enum Level: CaseIterable {
        case e0, e1, e2, e3, e4, e5

        var shadowRadius: CGFloat {
            Elevation.shadowRadius(self)
        }

        var shadowOffset: (CGFloat, CGFloat) {
            Elevation.shadowOffset(self)
        }

        var shadowOpacity: CGFloat {
            Elevation.shadowOpacity(self)
        }
    }

    let level: Level

    public func body(content: Content) -> some View {
        if level == .e0 {
            content
        } else {
            content
                .shadow(
                    color: Color.black.opacity(Elevation.baseShadowOpacity),
                    radius: Elevation.baseShadowRadius
                )
                .shadow(
                    color: Color.black.opacity(level.shadowOpacity),
                    radius: level.shadowRadius,
                    x: level.shadowOffset.0,
                    y: level.shadowOffset.1
                )
        }
    }
}
