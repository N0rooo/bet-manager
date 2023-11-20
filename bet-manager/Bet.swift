//
//  Bet.swift
//  bet-manager
//
//  Created by Thomas Aubert on 20/11/2023.
//

import SwiftUI

struct Bet: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let sport: String
    let odd: Double
}

extension Bet {
    static let previewBet: [Bet] = [
        Bet(name: "PSG - OM", image: "https://www.bkeeper-sport.com/wp-content/uploads/2021/10/football-tir.png", sport: "Football", odd: 2.0)]
}
