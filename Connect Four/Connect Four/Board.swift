//
//  Board.swift
//  Connect Four
//
//  Created by Tapan Sethi on 16/09/24.
//

import Foundation
import UIKit
var board = [[BoardItem]]()
func resetboard(){
    board.removeAll()
    for row in 0...5 {
        var rowArray = [BoardItem]()
        for column in 0...6 {
            let indexPath = IndexPath.init(item: column, section: row)
            let boardItem = BoardItem(indexpath: indexPath, tile: Tile.Empty)
            rowArray.append(boardItem)
        }
        board.append(rowArray)
    }
}
func getBoardItem (_ indexPath: IndexPath) -> BoardItem {
    return board[indexPath.section][indexPath.item]
}
func getLowestEmptyboardItem(_ column: Int) -> BoardItem?
{
    for row in (0...5).reversed(){
        let boardItem = board[row][column]
        if boardItem.emptyTile(){
            return boardItem
        }
    }
    return nil
}
func updateBoardWithBoardItem(_ boardItem: BoardItem){
    if let indexpath = boardItem.indexpath {
        board[indexpath.section][indexpath.item] = boardItem
    }
}
func boardIsFull() -> Bool {
    for row in board{
        for column in row {
            if column.emptyTile(){
                return false
            }
        }
    }
    return true
}
func victoryAchieved() -> Bool {
    
    return horizontalVictory() || verticalVictory() || diagonalVictory()
}
func horizontalVictory() -> Bool {
    for row in board {
        var consecutive = 0
        for column in row {
            if column.tile == currentTurnTile(){
                consecutive += 1
                if consecutive >= 4 {
                    return true
                }
            }
            else {
                consecutive = 0
            }
        }
    }
    return false
}
func verticalVictory() -> Bool {
    for column in 0...board.count {
        if checkVerticalcolumn(column) {
            return true
        }
    }
    return false
}
func checkVerticalcolumn(_ columnToCheck: Int) -> Bool {
    var consecutive = 0
    for row in board {
        if row[columnToCheck].tile == currentTurnTile(){
            consecutive += 1
            if consecutive >= 4 {
                return true
            }
        }
        else {
            consecutive = 0
        }
    }
    
    return false
}
func diagonalVictory() -> Bool {
    for column in 0...board.count {
        if checkDiagonalColumn(column , true , true){
            return true
        }
        if checkDiagonalColumn(column , true , false){
            return true
        }
        if checkDiagonalColumn(column , false , true){
            return true
        }
        if checkDiagonalColumn(column , false , false){
            return true
        }
    }
    return false
}
func checkDiagonalColumn(_ columnToCheck: Int , _ moveUp: Bool, _ reverserRows: Bool) -> Bool{
    var movingColumn = columnToCheck
    var consecutive = 0
    if reverserRows {
        for row in board.reversed() {
            if movingColumn < row.count && movingColumn >= 0 {
                if row[movingColumn].tile == currentTurnTile() {
                    consecutive += 1
                    if consecutive >= 4 {
                        return true
                    }
                }
                else {
                    consecutive = 0
                }
                movingColumn = moveUp ? movingColumn + 1 : movingColumn - 1
            }
        }
    }
    else {
        for row in board {
            if movingColumn < row.count && movingColumn >= 0 {
                if row[movingColumn].tile == currentTurnTile() {
                    consecutive += 1
                    if consecutive >= 4 {
                        return true
                    }
                }
                else {
                    consecutive = 0
                }
                movingColumn = moveUp ? movingColumn + 1 : movingColumn - 1
            }
        }
    }
    return false
}
