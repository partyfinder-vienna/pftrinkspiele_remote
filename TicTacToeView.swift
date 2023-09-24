//
//  TicTacToeView.swift
//  pfUI
//
//  Created by Felix Klug on 18.09.23.
//

import SwiftUI

struct TicTacToeView: View {
    @State private var player1Name = ""
    @State private var player2Name = ""
    @State private var currentPlayer = Player.player1
    @State private var isGameStarted = false
    @State private var board: [[Player?]] = Array(repeating: Array(repeating: nil, count: 3), count: 3)
    @State private var winner: Player? = nil
    @State private var showGameOver = false

    enum Player {
        case player1
        case player2
    }

    // Benutzerdefinierte Farben
    let customPink = Color(red: 247/255, green: 82/255, blue: 224/255) // #F752E0
    let customPurple = Color(red: 70/255, green: 3/255, blue: 66/255) // #460342

    var isGameOver: Bool {
        return winner != nil || isBoardFull()
    }

    var body: some View {
        ZStack {
            // Hintergrundfarbe der gesamten Seite setzen
            Color(hex: "460342").edgesIgnoringSafeArea(.all)

            VStack {
                Image("pflogo") // Verwenden Sie den Bildnamen
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 100) // Ändern Sie die Größe nach Bedarf
                
                    
                
                // Hier beginnt der body Ihrer Ansicht
                Text("Aktueller Spieler: \(currentPlayer == .player1 ? player1Name : player2Name)")
                    .font(.headline)
                    .foregroundColor(customPink) // Verwenden Sie die benutzerdefinierte Textfarbe
                    .padding()

                if !isGameStarted {
                    Text("Gib deinen Namen ein")
                                .font(.headline)
                                .foregroundColor(customPink)
                                .padding(.top, 20)
                            
                    
                    TextField("Name", text: $player1Name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Name", text: $player2Name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: {
                        if !player1Name.isEmpty && !player2Name.isEmpty {
                            initializeGame()
                            isGameStarted = true
                        }
                    }) {
                        Text("Spiel beginnen")
                            .font(.title)
                            .padding()
                            .background(customPink) // Verwenden Sie die benutzerdefinierte Farbe
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else if !showGameOver {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
                        ForEach(0..<3, id: \.self) { row in
                            ForEach(0..<3, id: \.self) { col in
                                Button(action: {
                                    if board[row][col] == nil {
                                        placeSymbol(row: row, col: col)
                                        checkForWin()
                                    }
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                            .frame(width: 80, height: 80)
                                        if let player = board[row][col] {
                                            Text(player == .player1 ? "X" : "O")
                                                .font(.system(size: 40))
                                                .foregroundColor(player == .player1 ? .red : .blue)
                                        }
                                    }
                                }
                                .disabled(isGameOver)
                            }
                        }
                    }
                } else {
                    VStack {
                        if let winningPlayer = winner {
                            Text(" \(winningPlayer == .player1 ? player1Name : player2Name) gewinnt!")
                                .font(.title)
                                .padding()
                                .foregroundColor(.white)
                        } else {
                            Text("Unentschieden")
                                .font(.title)
                                .padding()
                                .foregroundColor(.white)
                        }

                        Text("Spiel beendet")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.white)

                        Button(action: {
                            showGameOver = false
                            initializeGame()
                        }) {
                            Text("Neues Spiel")
                                .font(.title)
                                .padding()
                                .background(customPink) // Verwenden Sie die benutzerdefinierte Farbe
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
    }

    func initializeGame() {
        board = Array(repeating: Array(repeating: nil, count: 3), count: 3)
        currentPlayer = .player1
        winner = nil
        showGameOver = false
    }
    
    func placeSymbol(row: Int, col: Int) {
        board[row][col] = currentPlayer
        if checkForWin() {
            
            showGameOver = true
            return // Das Spiel ist beendet
        }
        currentPlayer = (currentPlayer == .player1) ? .player2 : .player1
    }




    func checkForWin() -> Bool {
        if checkRows() || checkColumns() || checkDiagonals() {
            if winner == nil {
                winner = currentPlayer
                showGameOver = true
            }
            return true
        } else if isBoardFull() {
            if winner == nil {
                winner = nil // Unentschieden
                showGameOver = true
            }
            return true
        }
        return false
    }






    func checkRows() -> Bool {
        for row in 0..<3 {
            if board[row][0] == currentPlayer && board[row][1] == currentPlayer && board[row][2] == currentPlayer {
                return true
            }
        }
        return false
    }

    func checkColumns() -> Bool {
        for col in 0..<3 {
            if board[0][col] == currentPlayer && board[1][col] == currentPlayer && board[2][col] == currentPlayer {
                return true
            }
        }
        return false
    }

    func checkDiagonals() -> Bool {
        if (board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer) ||
           (board[0][2] == currentPlayer && board[1][1] == currentPlayer && board[2][0] == currentPlayer) {
            return true
        }
        return false
    }

    func isBoardFull() -> Bool {
        for row in 0..<3 {
            for col in 0..<3 {
                if board[row][col] == nil {
                    return false
                }
            }
        }
        return true
    }
}

struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}
