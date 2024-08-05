//
//  BarProgressViewStyle.swift
//
//  Created by Jordi Gamez on 12/5/24.
//

import SwiftUI

public struct BarProgressViewStyle: ProgressViewStyle {

    private static let radius: CGFloat = 10

    private let color: Color
    private let backgroundColor: Color
    private let height: Double
    private let textSize: CGFloat

    public init(color: Color, backgroundColor: Color, height: Double, textSize: CGFloat) {
        self.color = color
        self.backgroundColor = backgroundColor
        self.height = height
        self.textSize = textSize
    }

    public func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? .zero

        GeometryReader { geometry in
            VStack(alignment: .leading) {
                configuration.label?.font(.system(size: textSize, weight: .bold))

                RoundedRectangle(cornerRadius: Self.radius)
                    .fill(backgroundColor)
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: Self.radius)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {
                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                    }

            }
        }
    }
}
