//
//  ContentView.swift
//  bet-manager
//
//  Created by Thomas Aubert on 20/11/2023.
//
import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @ObservedObject var betCollection: BetCollection = BetCollection(bets: Bet.previewBet)
    @State private var totalProfits: Float = 0
    
    var body: some View {
        TabView{
            NavigationView {
                MainView(betCollection: betCollection, isPresented: $isPresented, totalProfits: $totalProfits)
                    .onAppear {
                        updateProfits()
                    }
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Paris")
            }
            
            Text("Statistiques")
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Stats")
                }
            
            Text("Profil")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profil")
                }
            
        }
    }
    
    private func getTextColor(for value: Float) -> Color {
        if value > 0 {
            return .green
        } else if value < 0 {
            return .red
        } else {
            return .gray
        }
    }
    
    func updateProfits() {
        totalProfits = getTotalProfits()
    }
    
    func getTotalProfits() -> Float {
        var total: Float = 0
        for bet in betCollection.bets {
            total += Bet.getProfits(bet: bet)
        }
        return total
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(betCollection: BetCollection(bets: Bet.previewBet))
    }
}


