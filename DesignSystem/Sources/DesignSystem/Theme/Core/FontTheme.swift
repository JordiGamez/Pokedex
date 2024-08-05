//
//  FontTheme.swift
//
//  Created by Jordi Gamez on 27/5/24.
//

import SwiftUI

public protocol FontTheme {

    var largeTitle: Font { get }
    var title: Font { get }
    var headline: Font { get }
    var body: Font { get }
    var caption: Font { get }
}
