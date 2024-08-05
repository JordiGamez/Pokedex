//
//  UIToolkit+Images.swift
//
//  Created by Jordi Gamez on 17/4/24.
//

import SwiftUI
#if os(iOS)
import Kingfisher
#endif

public extension UIToolkit {

    @ViewBuilder
    static func asyncImage(
        _ url: String,
        size: CGFloat,
        placeholderImage: Image
    ) -> some View {
        #if os(iOS)
        KFImage(URL(string: url))
            .resizable()
            .placeholder {
                placeholder(
                    size: size,
                    image: placeholderImage
                )
            }
            .scaledToFit()
        #else
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        } placeholder: {
            placeholder(
                size: size,
                image: placeholderImage
            )
        }
        #endif
    }

    static func image(
        name: String,
        size: CGFloat? = nil
    ) -> some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: size)
    }

    static func systemImage(
        name: String,
        size: CGFloat
    ) -> some View {
        Image(systemName: name)
            .resizable()
            .frame(width: size, height: size)
    }
}

private extension UIToolkit {

    static func placeholder(
        size: CGFloat,
        image: Image
    ) -> some View {
        ZStack {
            LoadingView(loadingImage: image)
            Rectangle()
                .foregroundStyle(.clear)
                .frame(maxHeight: size)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
