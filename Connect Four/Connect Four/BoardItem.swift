//
//  BoardItem.swift
//  Connect Four
//
//  Created by Tapan Sethi on 16/09/24.
//

import Foundation
import UIKit
enum Tile {
    case Red
    case Yellow
    case Empty
}
struct BoardItem
{
    var indexpath: IndexPath!
    var tile: Tile!
    
    func redTile() -> Bool {
        return tile == Tile.Red
    }
    func yellowTile() -> Bool {
        return tile == Tile.Yellow
    }
    func emptyTile() -> Bool {
        return tile == Tile.Empty
    }
    func tilecolor() -> UIColor {
        if redTile() {
            return .red
        }
        if yellowTile(){
            return .systemYellow
        }
        return .white
    }
}
