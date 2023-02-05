//
//  TTTBrain.swift
//  TicTacToe
//
//  Created by Anastasia Hanna Ougolnikova on 11.11.22.
//

import Foundation

class TTTBrain : ObservableObject{
    @Published var playerX = true {
        didSet {
            aiMove()
        }
    }
    @Published var winner = " " {
        didSet {
            playerWon = true
        }
    }
    @Published var playerWon = false
    @Published var pB: [String] = Array(repeating: " ", count: 9) {
        didSet {
            checkWinner()
        }
    }
    @Published var counter = 0
    
    func checkWinner() {
        if (pB[0] == "✕" && pB[1] == "✕" && pB[2] == "✕") ||
            (pB[3] == "✕" && pB[4] == "✕" && pB[5] == "✕") ||
            (pB[6] == "✕" && pB[7] == "✕" && pB[8] == "✕") ||
            (pB[0] == "✕" && pB[4] == "✕" && pB[8] == "✕") ||
            (pB[2] == "✕" && pB[4] == "✕" && pB[6] == "✕") ||
            (pB[0] == "✕" && pB[3] == "✕" && pB[6] == "✕") ||
            (pB[1] == "✕" && pB[4] == "✕" && pB[7] == "✕") ||
            (pB[2] == "✕" && pB[5] == "✕" && pB[8] == "✕") {
            winner = "YOU WON!"
        }
        if (pB[0] == "●" && pB[1] == "●" && pB[2] == "●") ||
            (pB[3] == "●" && pB[4] == "●" && pB[5] == "●") ||
            (pB[6] == "●" && pB[7] == "●" && pB[8] == "●") ||
            (pB[0] == "●" && pB[4] == "●" && pB[8] == "●") ||
            (pB[2] == "●" && pB[4] == "●" && pB[6] == "●") ||
            (pB[0] == "●" && pB[3] == "●" && pB[6] == "●") ||
            (pB[1] == "●" && pB[4] == "●" && pB[7] == "●") ||
            (pB[2] == "●" && pB[5] == "●" && pB[8] == "●") {
            winner = "GAME OVER!"
        }
    }
    
    func aiMove() {
        let random = Int.random(in: 0...8)
        if !playerWon {
            if !playerX {
                if counter < 9  && pB[random] != "✕" && pB[random] != "●" {
                    if counter == 1 && (pB[0] == "✕" || pB[2] == "✕" || pB[6] == "✕" || pB[8] == "✕") {
                        pB[4] = "●"
                    } else if (pB[0] == " " && pB[1] == "●" && pB[2] == "●") {
                        pB[0] = "●"
                    } else if (pB[0] == "●" && pB[1] == " " && pB[2] == "●") {
                        pB[1] = "●"
                    } else if (pB[0] == "●" && pB[1] == "●" && pB[2] == " ") {
                        pB[2] = "●"
                    } else if (pB[3] == " " && pB[4] == "●" && pB[5] == "●") {
                        pB[3] = "●"
                    } else if (pB[3] == "●" && pB[4] == " " && pB[5] == "●") {
                        pB[4] = "●"
                    } else if (pB[3] == "●" && pB[4] == "●" && pB[5] == " ") {
                        pB[5] = "●"
                    } else if (pB[6] == " " && pB[7] == "●" && pB[8] == "●") {
                        pB[6] = "●"
                    } else if (pB[6] == "●" && pB[7] == " " && pB[8] == "●") {
                        pB[7] = "●"
                    } else if (pB[6] == "●" && pB[7] == "●" && pB[8] == " ") {
                        pB[8] = "●"
                    } else if (pB[0] == " " && pB[4] == "●" && pB[8] == "●") {
                        pB[0] = "●"
                    } else if (pB[0] == "●" && pB[4] == " " && pB[8] == "●") {
                        pB[4] = "●"
                    } else if (pB[0] == "●" && pB[4] == "●" && pB[8] == " ") {
                        pB[8] = "●"
                    } else if (pB[2] == " " && pB[4] == "●" && pB[6] == "●") {
                        pB[2] = "●"
                    } else if (pB[2] == "●" && pB[4] == " " && pB[6] == "●") {
                        pB[4] = "●"
                    } else if (pB[2] == "●" && pB[4] == "●" && pB[6] == " ") {
                        pB[6] = "●"
                    } else if (pB[0] == " " && pB[3] == "●" && pB[6] == "●") {
                        pB[0] = "●"
                    } else if (pB[0] == "●" && pB[3] == " " && pB[6] == "●") {
                        pB[3] = "●"
                    } else if (pB[0] == "●" && pB[3] == "●" && pB[6] == " ") {
                        pB[6] = "●"
                    } else if (pB[1] == " " && pB[4] == "●" && pB[7] == "●") {
                        pB[1] = "●"
                    } else if (pB[1] == "●" && pB[4] == " " && pB[7] == "●") {
                        pB[4] = "●"
                    } else if (pB[1] == "●" && pB[4] == "●" && pB[7] == " ") {
                        pB[7] = "●"
                    } else if (pB[2] == " " && pB[5] == "●" && pB[8] == "●") {
                        pB[2] = "●"
                    } else if (pB[2] == "●" && pB[5] == " " && pB[8] == "●") {
                        pB[5] = "●"
                    } else if (pB[2] == "●" && pB[5] == "●" && pB[8] == " ") {
                        pB[8] = "●"
                    // check if block possible
                    } else if(pB[0] == " " && pB[1] == "✕" && pB[2] == "✕") {
                        pB[0] = "●"
                    } else if (pB[0] == "✕" && pB[1] == " " && pB[2] == "✕") {
                        pB[1] = "●"
                    } else if (pB[0] == "✕" && pB[1] == "✕" && pB[2] == " ") {
                        pB[2] = "●"
                    } else if (pB[3] == " " && pB[4] == "✕" && pB[5] == "✕") {
                        pB[3] = "●"
                    } else if (pB[3] == "✕" && pB[4] == " " && pB[5] == "✕") {
                        pB[4] = "●"
                    } else if (pB[3] == "✕" && pB[4] == "✕" && pB[5] == " ") {
                        pB[5] = "●"
                    } else if (pB[6] == " " && pB[7] == "✕" && pB[8] == "✕") {
                        pB[6] = "●"
                    } else if (pB[6] == "✕" && pB[7] == " " && pB[8] == "✕") {
                        pB[7] = "●"
                    } else if (pB[6] == "✕" && pB[7] == "✕" && pB[8] == " ") {
                        pB[8] = "●"
                    } else if (pB[0] == " " && pB[4] == "✕" && pB[8] == "✕") {
                        pB[0] = "●"
                    } else if (pB[0] == "✕" && pB[4] == " " && pB[8] == "✕") {
                        pB[4] = "●"
                    } else if (pB[0] == "✕" && pB[4] == "✕" && pB[8] == " ") {
                        pB[8] = "●"
                    } else if (pB[2] == " " && pB[4] == "✕" && pB[6] == "✕") {
                        pB[2] = "●"
                    } else if (pB[2] == "✕" && pB[4] == " " && pB[6] == "✕") {
                        pB[4] = "●"
                    } else if (pB[2] == "✕" && pB[4] == "✕" && pB[6] == " ") {
                        pB[6] = "●"
                    } else if (pB[0] == " " && pB[3] == "✕" && pB[6] == "✕") {
                        pB[0] = "●"
                    } else if (pB[0] == "✕" && pB[3] == " " && pB[6] == "✕") {
                        pB[3] = "●"
                    } else if (pB[0] == "✕" && pB[3] == "✕" && pB[6] == " ") {
                        pB[6] = "●"
                    } else if (pB[1] == " " && pB[4] == "✕" && pB[7] == "✕") {
                        pB[1] = "●"
                    } else if (pB[1] == "✕" && pB[4] == " " && pB[7] == "✕") {
                        pB[4] = "●"
                    } else if (pB[1] == "✕" && pB[4] == "✕" && pB[7] == " ") {
                        pB[7] = "●"
                    } else if (pB[2] == " " && pB[5] == "✕" && pB[8] == "✕") {
                        pB[2] = "●"
                    } else if (pB[2] == "✕" && pB[5] == " " && pB[8] == "✕") {
                        pB[5] = "●"
                    } else if (pB[2] == "✕" && pB[5] == "✕" && pB[8] == " ") {
                        pB[8] = "●"
                        // random placement
                    } else {
                        pB[random] = "●"
                    }
                    playerX = true
                    counter += 1
                } else if counter < 9 {
                    playerX = false
                    aiMove()
                } else {
                    playerWon = true
                    winner = "GAME OVER!"
                }
            }
        }
    }
}
