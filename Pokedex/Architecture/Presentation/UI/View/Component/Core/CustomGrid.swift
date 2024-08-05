//
//  CustomGrid.swift
//  Pokedex
//
//  Created by Jordi Gamez on 13/6/24.
//

import SwiftUI

struct CustomGrid<Content: View>: View {

    let alignment: Alignment
    let itemsCount: Int
    let itemsPerRow: Int
    let content: (Int) -> Content

    var body: some View {
        Grid(alignment: alignment) {
            ForEach(0..<rowsNeeded) { rowIndex in
                row(rowIndex)
            }
        }
    }
}

private extension CustomGrid {

    var rowsNeeded: Int {
        itemsCount / itemsPerRow + (rest == 0 ? 0 : 1)
    }

    var rest: Int {
        itemsCount % itemsPerRow
    }

    func row(_ rowIndex: Int) -> some View {
        GridRow {
            ForEach(0..<itemsPerRow) { columnIndex in
                let number = (rowIndex * itemsPerRow) + (columnIndex * 1)
                if number < itemsCount {
                    content(number)
                }
            }
        }
    }
}
