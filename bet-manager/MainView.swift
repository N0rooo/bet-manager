//
//  MainView.swift
//  bet-manager
//
//  Created by Thomas Aubert on 23/11/2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var betCollection: BetCollection
    @Binding var isPresented: Bool
    @Binding var totalProfits: Float
    
    var body: some View {
        VStack {
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
                        updateProfits()
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
                    .onDisappear{
                        updateProfits()
                    }
            }
            Spacer()
            
            TotalView(totalProfits: totalProfits)
            Divider()
                .padding(.bottom, 10)
        }
    }
    
    private func updateProfits() {
        totalProfits = getTotalProfits()
    }
    
    private func getTotalProfits() -> Float {
        var total: Float = 0
        for bet in betCollection.bets {
            total += Bet.getProfits(bet: bet)
        }
        return total
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            betCollection: BetCollection(bets: Bet.previewBet),
            isPresented: .constant(false),
            totalProfits: .constant(100.0)
        )
    }
}
