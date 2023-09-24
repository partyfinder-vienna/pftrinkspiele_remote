//
//  ContentView.swift
//  pfUI
//
//  Created by Felix Klug on 12.09.23.
//
import SwiftUI

struct ContentView: View {

    let customPink = Color(red: 247/255, green: 82/255, blue: 224/255) // #F752E0
    let customPurple = Color(red: 70/255, green: 3/255, blue: 66/255) // #460342

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Image("pflogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)

                    Text("Trinkspiele")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(customPink)
                        .frame(maxWidth: .infinity)

                    NavigationLink(destination: trinkspiel3View()) {
                        Image("ButtonK")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 140)
                            .cornerRadius(10.0)
                    }

                    NavigationLink(destination: TicTacToeView()) {
                        Image("ButtonT")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 140)
                            .cornerRadius(10.0)
                    }

                    NavigationLink(destination: MemoryGameView()) {
                        Image("ButtonM")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 140)
                            .cornerRadius(10.0)
                    }

                   
                }
                .padding()
            }
            .background(Color(hex: "460342"))
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
