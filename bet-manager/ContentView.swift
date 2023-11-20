//
//  ContentView.swift
//  bet-manager
//
//  Created by Thomas Aubert on 20/11/2023.
//
import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @State var bets: [Bet]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Bet Manager").font(.title).fontWeight(.bold)) {
                    ForEach(bets, id: \.id) { bet in
                        Text(bet.name)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                isPresented.toggle()
            }) {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
                    .padding()
            }
            )
            .sheet(isPresented: $isPresented) {
                NewBetView(bets: $bets)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(bets: Bet.previewBet)
    }
}
