import SwiftUI

struct MemoryGameView: View {
    @State private var player1Name = ""
    @State private var player2Name = ""
    @State private var currentPlayer = Player.player1
    @State private var isGameStarted = false
    @State private var cards: [Card] = []
    @State private var selectedCardIndices: [Int] = []
    @State private var player1PairsFound = 0
    @State private var player2PairsFound = 0
    @State private var winner: Player? = nil
    @State private var showGameOver = false
    @State private var canSelectCards = true // Steuert, ob der nächste Spieler Karten auswählen kann

    let numberOfRows = 4
    let numberOfColumns = 4
    
    enum Player {
        case player1
        case player2
    }
   
    // Benutzerdefinierte Farben
    let customPink = Color(red: 247/255, green: 82/255, blue: 224/255) // #F752E0
    let customPurple = Color(red: 70/255, green: 3/255, blue: 66/255) // #460342

    var body: some View {
        ZStack {
            // Hintergrundfarbe der gesamten Seite setzen
            Color(hex: "460342").edgesIgnoringSafeArea(.all)

            VStack {
                // Hier beginnt der body Ihrer Ansicht
                Image("pflogo") // Verwenden Sie den Bildnamen
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 100) // Ändern Sie die Größe nach Bedarf

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
                    VStack {
                        HStack {
                            VStack {
                                Text(" \(player1Name)")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.white)
                                Text("Score: \(player1PairsFound)")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(customPink.opacity(1)) // Verwenden Sie die benutzerdefinierte Farbe
                            .cornerRadius(10)

                            Spacer()

                            VStack {
                                Text(" \(player2Name)")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.white)
                                Text("Score: \(player2PairsFound)")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(customPink.opacity(1)) // Verwenden Sie die benutzerdefinierte Farbe
                            .cornerRadius(10)
                        }
                        .padding()

                        LazyVGrid(columns: Array(repeating: GridItem(), count: numberOfColumns), spacing: 10) {
                            ForEach(cards.indices, id: \.self) { index in
                                MemoryCardView(card: $cards[index], isClickable: canSelectCards, onTap: {
                                    if selectedCardIndices.count < 2 && !cards[index].isFaceUp && !cards[index].isMatched {
                                        selectedCardIndices.append(index)
                                        cards[index].isFaceUp = true

                                        if selectedCardIndices.count == 2 {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                checkForMatchingCards()
                                            }
                                        }
                                    }
                                })
                            }
                        }
                        .padding()
                    }
                } else {
                    VStack {
                        
                        Text(" \(winner == .player1 ? player1Name : player2Name) gewinnt!")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                        
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
        var cardContents = [String]()

        for i in 1...8 {
            cardContents.append("memory\(i)")
            cardContents.append("memory\(i)")
        }

        cardContents.shuffle()
        cards = cardContents.map { Card(content: $0) }
        selectedCardIndices = []
        currentPlayer = .player1
        player1PairsFound = 0
        player2PairsFound = 0
        winner = nil
        showGameOver = false
        canSelectCards = true // Setze die Kartenwahl für das neue Spiel zurück
    }

    func checkForMatchingCards() {
        let index1 = selectedCardIndices[0]
        let index2 = selectedCardIndices[1]

        if cards[index1].content == cards[index2].content {
            cards[index1].isMatched = true
            cards[index2].isMatched = true

            if currentPlayer == .player1 {
                player1PairsFound += 1
            } else {
                player2PairsFound += 1
            }

            if player1PairsFound + player2PairsFound == 8 {
                determineWinner()
            } else {
                canSelectCards = true // Erlaube dem aktuellen Spieler, erneut Karten auszuwählen
            }
        } else {
            cards[index1].isFaceUp = false
            cards[index2].isFaceUp = false
            self.currentPlayer = (self.currentPlayer == .player1) ? .player2 : .player1
            canSelectCards = true // Erlaube dem nächsten Spieler, Karten auszuwählen
        }

        selectedCardIndices = []
    }

    func determineWinner() {
        if player1PairsFound > player2PairsFound {
            winner = .player1
        } else if player2PairsFound > player1PairsFound {
            winner = .player2
        } else {
            winner = nil
        }

        showGameOver = true
    }
}

struct MemoryCardView: View {
    @Binding var card: Card
    var isClickable: Bool
    var onTap: () -> Void
    
    let customPurple = Color(red: 70/255, green: 3/255, blue: 66/255) // #460342
    let customPink = Color(red: 247/255, green: 82/255, blue: 224/255) // #F752E0

    var body: some View {
            ZStack {
                if card.isFaceUp && !card.isMatched {
                    Image(card.content)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                } else {
                    if card.isMatched {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(customPurple)
                            .frame(width: 100, height: 100)
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(customPink) // Hintergrundfarbe für die Karte
                            .frame(width: 80, height: 100)
                            .overlay(
                                Image("LogoGlass")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                            )
                    }


                }
            }
            .aspectRatio(2/3, contentMode: .fit)
            .onTapGesture {
                if isClickable && !card.isMatched {
                    onTap()
                }
            }
        }
    }
struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView()
    }
}

struct Card: Identifiable {
    var id = UUID()
    var isFaceUp = false
    var isMatched = false
    var content: String
}
