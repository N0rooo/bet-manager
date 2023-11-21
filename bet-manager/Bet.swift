//
//  Bet.swift
//  bet-manager
//
//  Created by Thomas Aubert on 20/11/2023.
//

import SwiftUI

struct BetStatus: Hashable {
    let name: String
    let color: Color
}

struct Sport: Hashable {
    let name: String
    let imageUrl: String
}


struct Bet: Identifiable {
    let id = UUID()
    let name: String
    let sport: Sport
    let odd: Float
    let status: BetStatus
    let cash: Float
    let created_at: String
    
}

extension Bet {
    static let previewBet: [Bet] = [
        Bet(name: "PSG - OM", sport: Sport(name: "Football", imageUrl: "https://media.istockphoto.com/id/610241662/fr/photo/ballon-de-football-isol%C3%A9-sur-fond-blanc.jpg?s=612x612&w=0&k=20&c=yulUStMmoLbwnNrLT8eNcN_IX4Af8eyPLKhHyOPwFjY="), odd: 2, status: BetStatus(name: "En cours", color: .gray), cash: 10, created_at: formattedCurrentDate()),]
    
    static func formattedCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())
    }
    
    static func getProfits(bet: Bet) -> Float {
        var profits: Float = 0
            switch bet.status.name {
            case "Perdu":
                profits = -bet.cash
                
            case "Gagné":
                profits = bet.cash * bet.odd - bet.cash
            default:
                profits = 0
                
            }
        
        
        return profits
    }
    
    
}
