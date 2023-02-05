//
//  ContentView.swift
//  TicTacToe
//
//  Created by Anastasia Hanna Ougolnikova on 11.11.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var brain = TTTBrain()
    var body: some View {
        VStack(alignment: .center) {
            Text("Tic Tac Toe")
                .foregroundColor(.orange)
                .font(.system(size: 50))
            ForEach(0..<3, id: \.self) { row in
                HStack(alignment: .center) {
                    ForEach(0..<3, id: \.self ) { column in
                        Button(action: {turn(row: row, column: column)}) {
                            Text(brain.pB[3 * row + column])
                                .frame(width: 120, height: 120, alignment: .center)
                                .background(Color.white.cornerRadius(40).opacity(0.13))
                                .clipShape(Rectangle())
                                .font(.system(size: 100))
                                .foregroundColor(.orange)
                        }
                    }
                }
            }
            Text(brain.winner)
                .foregroundColor(.orange)
                .font(.system(size: 45) .bold())
                .padding()
            Button(action: {reset()}) {
                Text("reset")
                    .foregroundColor(.orange)
                    .font(.system(size: 30))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
    
    func turn(row: Int, column: Int) {
        if !brain.playerWon {
            if brain.pB[3 * row + column] == " " {
                brain.pB[3 * row + column] = "✕"
                brain.counter += 1
                brain.playerX.toggle()
            }
        }
    }
    
    func reset() {
        brain.winner = " "
        brain.playerX = true
        brain.playerWon = false
        brain.counter = 0
        return brain.pB = Array(repeating: " ", count: 9)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
