//
//  ViewController.swift
//  tic-tac-toe
//
//  Created by Ramesh Abeysekara on 2023-10-26.
//

import UIKit

class ViewController: UIViewController {
    
    private var playerPiece = "X"
    private var gameBoard = [String](repeating: "", count: 9)
    private let winningCombinations: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
        [0, 4, 8], [2, 4, 6]             // diagonals
    ]
    
    @IBOutlet var squares: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
    }
    
    func displayWinnerAlert(_ winner: String) {
        let alert = UIAlertController(title: "Winner!", message: "Player \(winner) wins!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.resetGame()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onClickSquare(_ sender: UIButton) {
        guard let index = squares.firstIndex(of: sender) else { return }
        
        if gameBoard[index] == "" {
            gameBoard[index] = playerPiece
            sender.setTitle(playerPiece, for: .normal)
            
            if checkForWin(playerPiece) {
                // Display a message or perform actions for win
                displayWinnerAlert(playerPiece)
                return
            }
            
            if checkForDraw() {
                let alert = UIAlertController(title: "Draw", message: "It's a draw!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.resetGame()
                }
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                return
            }
            
            // Switch player turn
            playerPiece = (playerPiece == "X") ? "O" : "X"
        }
    }
    
    func checkForWin(_ piece: String) -> Bool {
        for combination in winningCombinations {
            if gameBoard[combination[0]] == piece &&
                gameBoard[combination[1]] == piece &&
                gameBoard[combination[2]] == piece {
                return true
            }
        }
        return false
    }
    
    func checkForDraw() -> Bool {
        return !gameBoard.contains("")
    }
    
    func resetGame() {
        playerPiece = "X"
        gameBoard = [String](repeating: "", count: 9)
        
        for square in squares {
            square.setTitle("", for: .normal)
        }
    }
    
    @IBAction func resetClicked(_ sender: UIButton) {
        resetGame()
    }
    
    
}

