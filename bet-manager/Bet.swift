//
//  Bet.swift
//  bet-manager
//
//  Created by Thomas Aubert on 20/11/2023.
//

import SwiftUI

struct BetStatus: Hashable, Decodable {
    let name: String
    let colorHex: String
    var color: Color {
        return Color(UIColor(hex: colorHex) ?? .clear)
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: 1.0)
    }
}


struct Sport: Hashable, Codable {
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

class BetCollection: ObservableObject, Decodable {
    @Published var bets: [Bet]

    enum CodingKeys: String, CodingKey {
        case bets
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bets = try container.decode([Bet].self, forKey: .bets)
    }

    init(bets: [Bet]) {
        self.bets = bets
    }
}

class Bet: Identifiable, ObservableObject, Decodable {
    @Published var id: UUID = UUID()
    @Published var name: String
    @Published var sport: Sport
    @Published var competition: String
    @Published var odd: Float
    @Published var status: BetStatus
    @Published var cash: Float
    @Published var createdAt: String
    @Published var isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sport
        case competition
        case odd
        case status
        case cash
        case createdAt
        case isFavorite
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        sport = try container.decode(Sport.self, forKey: .sport)
        competition = try container.decode(String.self, forKey: .competition)
        odd = try container.decode(Float.self, forKey: .odd)
        status = try container.decode(BetStatus.self, forKey: .status)
        cash = try container.decode(Float.self, forKey: .cash)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }

    init(id: UUID, name: String, sport: Sport, competition: String, odd: Float, status: BetStatus, cash: Float, createdAt: String, isFavorite: Bool) {
        self.id = id
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
    static let previewBet: [Bet] = []

    static func formattedCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())
    }
    
    static func formattedCurrentDateForDatabase() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
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
