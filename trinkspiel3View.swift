//
//  trinkspiel3View.swift
//  pfUI
//
//  Created by Felix Klug on 13.09.23.
//
import SwiftUI

struct trinkspiel3View: View {
    // Liste der Bildnamen von Bild1 bis Bild100
    let bildnamen: [String] = {
        var namen = [String]()
        for i in 1...100 {
            namen.append("Bild\(i)")
        }
        return namen
    }()
    
    // Verfolgen der bereits verwendeten Karten
    @State private var verwendeteKarten: Set<String> = []
    
    // Aktuell angezeigter Bildindex
    @State private var aktuellerIndex = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "460342")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    // Bedingte Anzeige des Bildes
                    if aktuellerIndex < bildnamen.count {
                        Image(bildnamen[aktuellerIndex])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400, height: 400)
                            .padding()
                    } else {
                        // Wenn das Spiel zu Ende ist, zeige die "karteende"
                        Text("Spiel ist zu Ende")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    // Button zum Anzeigen des nächsten Bildes oder Neustarten des Spiels
                    Button(action: {
                        if verwendeteKarten.count == bildnamen.count {
                            // Alle Karten wurden verwendet, das Spiel ist zu Ende
                            aktuellerIndex = bildnamen.count
                        } else {
                            // Zufälligen Bildindex generieren, der noch nicht verwendet wurde
                            var zufälligerIndex = Int.random(in: 0..<bildnamen.count)
                            while verwendeteKarten.contains(bildnamen[zufälligerIndex]) {
                                zufälligerIndex = (zufälligerIndex + 1) % bildnamen.count
                            }
                            
                            aktuellerIndex = zufälligerIndex
                            
                            // Die verwendete Karte in die Liste der verwendeten Karten aufnehmen
                            verwendeteKarten.insert(bildnamen[zufälligerIndex])
                        }
                    }) {
                        Text(aktuellerIndex == bildnamen.count ? "Spiel neu starten" : "Nächste Karte")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 20, leading: 70, bottom: 20, trailing: 70))
                            .background(Color(hex: "F752E0"))
                            .cornerRadius(10.0)
                    }
                    .padding()
                }
                .navigationBarBackButtonHidden(true)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            // Initialisiere die Liste der verwendeten Karten mit dem Startbild
            verwendeteKarten.insert(bildnamen[aktuellerIndex])
        }
    }
}

struct trinkspiel3View_Previews: PreviewProvider {
    static var previews: some View {
        trinkspiel3View()
    }
}
