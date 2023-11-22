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

struct SportApi: Hashable, Codable {
    let key: String
    let group: String
    let title: String
    let description: String
    let active: Bool
    let has_outrights: Bool
}

class BetCollection: ObservableObject {
    @Published var bets: [Bet]
    init(bets: [Bet]) {
        self.bets = bets
    }
}



class Bet: Identifiable, ObservableObject {
    let id = UUID()
    @Published var name: String
    @Published var sport: Sport
    @Published var competition: String
    @Published var odd: Float
    @Published var status: BetStatus
    @Published var cash: Float
    @Published var createdAt: String
    @Published var isFavorite: Bool
    
    
    init(name: String, sport: Sport, competition: String, odd: Float, status: BetStatus, cash: Float, createdAt: String, isFavorite: Bool) {
        self.name = name
        self.sport = sport
        self.competition = competition
        self.odd = odd
        self.status = status
        self.cash = cash
        self.createdAt = createdAt
        self.isFavorite = isFavorite
    }
}



extension Bet {
    static let previewBet: [Bet] = [
        Bet(name: "PSG - OM", sport: Sport(name: "Football", imageUrl: "https://media.istockphoto.com/id/610241662/fr/photo/ballon-de-football-isol%C3%A9-sur-fond-blanc.jpg?s=612x612&w=0&k=20&c=yulUStMmoLbwnNrLT8eNcN_IX4Af8eyPLKhHyOPwFjY="), competition: "Ligue 1 - France", odd: 2, status: BetStatus(name: "En cours", color: .gray), cash: 10, createdAt: formattedCurrentDate(), isFavorite: false),]
    
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
