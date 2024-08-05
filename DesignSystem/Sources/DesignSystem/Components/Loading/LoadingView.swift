//
//  LoadingView.swift
//
//  Created by Jordi Gamez on 17/4/24.
//

import SwiftUI

public struct LoadingView: View {

    @EnvironmentObject private var theme: ThemeManager

    @State private var rotationDegrees = 0.0

    static private let loadingSize: CGFloat = 100
    static private let rotationDegrees: CGFloat = 360

    private var animation: Animation {
        .linear
        .speed(0.1)
        .repeatForever(autoreverses: false)
    }

    private let loadingImage: Image

    public init(loadingImage: Image) {
        self.loadingImage = loadingImage
    }

    public var body: some View {
        loadingImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: Self.loadingSize)
            .rotationEffect(.degrees(rotationDegrees))
            .onAppear {
                withAnimation(animation) {
                    rotationDegrees = Self.rotationDegrees
                }
            }
    }
}

#Preview {
    LoadingView(
        loadingImage: Image(systemName: "gear")
    )
}
