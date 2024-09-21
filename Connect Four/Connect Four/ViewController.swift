//
//  ViewController.swift
//  Connect Four
//
//  Created by Tapan Sethi on 16/09/24.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
  
    
   

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var turnImage: UIImageView!
    var redScore = 0
    var yellowScore = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        resetboard()
        setCellWidthHeight()
    }
    func setCellWidthHeight(){
        let width = collectionView.frame.size.width / 9
        let height = collectionView.frame.size.height / 6
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return board.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCell" , for: indexPath) as! BoardCell
        let boardItem = getBoardItem(indexPath)
        cell.image.tintColor = boardItem.tilecolor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let column = indexPath.item
        if var boardItem = getLowestEmptyboardItem(column){
            if let cell = collectionView.cellForItem(at: boardItem.indexpath) as? BoardCell {
                cell.image.tintColor = currentTurnColor()
                boardItem.tile = currentTurnTile()
                updateBoardWithBoardItem(boardItem)
                if victoryAchieved(){
                    if yellowTurn(){
                        yellowScore += 1
                    }
                    if redTurn() {
                        redScore += 1
                    }
                    resultAlert(currentTurnVictoryMessage())

                }
                if boardIsFull(){
                    resultAlert("Draw")
                }
                toggleTurn(turnImage)
            }
        }
    }
    func resultAlert(_ title : String){
        let message = "\nRed: " + String(redScore) + "\n\nYellow: " + String(yellowScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default,handler: {  [self] (_) in
            resetboard()
            resetcells()
        }))
        self.present(ac, animated: true)
        
    }
    func resetcells(){
        for cell in collectionView.visibleCells as! [BoardCell]{
            cell.image.tintColor = .white
        }
    }
}

