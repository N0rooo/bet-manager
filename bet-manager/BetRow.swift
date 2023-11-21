//
//  BetRow.swift
//  bet-manager
//
//  Created by Thomas Aubert on 21/11/2023.
//

import SwiftUI

struct BetRow: View {
   @ObservedObject var bet: Bet
    var body: some View {
        let profit: Float = Bet.getProfits(bet: bet)
        let isWon: Bool = bet.status.name != "Perdu"
        HStack{
            VStack(alignment: .leading){
                HStack{
                    Text(bet.createdAt + " -")
                    Text(bet.status.name)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(bet.status.color)
                        .cornerRadius(8)
                    
                }.foregroundColor(.gray)
                HStack{
                    AsyncImage(url: URL(string: bet.sport.imageUrl)) {
                        image in
                        image.resizable()
                            .clipShape( Circle())
                    }placeholder: {
                        Circle()
                    }.frame(
                        width: 30,
                        height: 30
                    )
                    VStack(alignment: .leading){
                        Text(bet.name)
                        Text(bet.sport.name)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                }
            }
            Divider()
            VStack{
                Text("\(isWon ? "+" : "")\(String(profit))€")
                    .foregroundColor(bet.status.color)
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    Text("\(String(bet.cash))€ -  \(String(bet.odd))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
}

