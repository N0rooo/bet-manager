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
        NavigationView {
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
                
                VStack{
                    Text("Total :")
                        .foregroundColor(.gray)
                    HStack {
                        Spacer()
                        Text("\(totalProfits > 0 ? "+" : "") \(String(format: "%.2f", totalProfits)) €")
                            .fontWeight(.bold)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(getTextColor(for: totalProfits))
                        
                        Spacer()
                    }
                    
                }.padding(.vertical, 30)
            }
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                updateProfits()
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

