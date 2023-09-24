//
//  trinkspiel2View.swift
//  pfUI
//
//  Created by Felix Klug on 13.09.23.
//
import SwiftUI

struct trinkspiel2View: View {
    @State var gridData: [[String]] =
                   [["herz4", "pik4", "karo4", "kreuz4"],
                    ["herz3", "pik3", "karo3", "kreuz3"],
                    ["herz2", "pik2", "karo2", "kreuz2"],
                    ["herz1", "pik1", "karo1", "kreuz1"]]
    
    let cardImages = ["herzass", "pikass", "karoass", "kreuzass"]
    @State var selectedCard: String? = nil
    @State var showRandomCard: Bool = false
    @State var isHerzAssVisible = false
    @State var isPikAssVisible = false
    @State var isKaroAssVisible = false
    @State var isKreuzAssVisible = false

    var body: some View {
        NavigationView { // Hier wird die NavigationView hinzugefügt
            VStack(spacing: 0) {
                VStack {
                    ForEach(0..<4, id: \.self) { row in
                        HStack {
                            ForEach(0..<4, id: \.self) { col in
                                if isHerzAssVisible && gridData[row][col] == "herz1" {
                                    Image("herzass")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .border(Color.black, width: 1)
                                } else if isPikAssVisible && gridData[row][col] == "pik1" {
                                    Image("pikass")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .border(Color.black, width: 1)
                                } else if isKaroAssVisible && gridData[row][col] == "karo1" {
                                    Image("karoass")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .border(Color.black, width: 1)
                                } else if isKreuzAssVisible && gridData[row][col] == "kreuz1" {
                                    Image("kreuzass")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .border(Color.black, width: 1)
                                } else {
                                    if let index = cardImages.firstIndex(of: gridData[row][col]),
                                       let imageName = selectedCard == cardImages[index] ? selectedCard : nil {
                                        Image(imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            .border(Color.black, width: 1)
                                    } else {
                                        Text("")
                                            .frame(width: 50, height: 50)
                                            .border(Color.black, width: 1)
                                    }
                                }
                            }
                        }
                    }
                }
                .opacity((selectedCard == nil || isHerzAssVisible || isPikAssVisible || isKaroAssVisible || isKreuzAssVisible) ? 1 : 0)
                
                ZStack {
                    HStack {
                        ForEach(cardImages, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .border(Color.black, width: 1)
                                .disabled(true)
                        }
                    }
                    .opacity(selectedCard == nil ? 1 : 0)
                    
                    if let selectedCard = selectedCard {
                        if selectedCard == "herzass" {
                            Image("herzass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .zIndex(10)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.white)
                                .edgesIgnoringSafeArea(.all)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        self.selectedCard = nil
                                        self.showRandomCard = false
                                        self.isHerzAssVisible = true
                                    }
                                }
                        } else if selectedCard == "pikass" {
                            Image("pikass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .zIndex(10)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.white)
                                .edgesIgnoringSafeArea(.all)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        self.selectedCard = nil
                                        self.showRandomCard = false
                                        self.isPikAssVisible = true
                                    }
                                }
                        } else if selectedCard == "karoass" {
                            Image("karoass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .zIndex(10)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.white)
                                .edgesIgnoringSafeArea(.all)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        self.selectedCard = nil
                                        self.showRandomCard = false
                                        self.isKaroAssVisible = true
                                    }
                                }
                        } else if selectedCard == "kreuzass" {
                            Image("kreuzass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .zIndex(10)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.white)
                                .edgesIgnoringSafeArea(.all)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        self.selectedCard = nil
                                        self.showRandomCard = false
                                        self.isKreuzAssVisible = true
                                    }
                                }
                        }
                    }
                }
                .padding()
                
                Button(action: {
                    selectedCard = cardImages.randomElement()
                    showRandomCard = true
                }) {
                    Text("Klick mich!")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .opacity(selectedCard == nil ? 1 : 0)
                }
            }
            
        }
    }
    
    struct trinkspiel2View_Previews: PreviewProvider {
        static var previews: some View {
            trinkspiel2View()
        }
    }
}
