//
//  ContentView.swift
//  bet-manager
//
//  Created by Thomas Aubert on 20/11/2023.
//
import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @StateObject var betCollection: BetCollection
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Bet Manager").font(.title).fontWeight(.bold)) {
                    ForEach(betCollection.bets, id: \.id) { bet in
                        NavigationLink {
                            BetDetailsView(bet: bet)
                        } label: {
                            BetRow(bet: bet)
                        }
                        
                    }
                    
                    .onDelete(perform: { bet in
                        betCollection.bets.remove(atOffsets: bet)
                        
                    })
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                isPresented.toggle()
            }) {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .padding()
            }
            )
            
            .sheet(isPresented: $isPresented) {
                NewBetView(betCollection: betCollection, isPresented: $isPresented)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( betCollection: BetCollection(bets: Bet.previewBet))
    }
}
