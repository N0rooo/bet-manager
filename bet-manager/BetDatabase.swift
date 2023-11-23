//  bet-manager
//
//  Created by Thomas Aubert on 23/11/2023.
//

import Supabase
import Foundation

struct BetInDatabase: Decodable, Encodable{
    let id: UUID
    let name: String
    let sport: String
    let competition: String
    let odd: Float
    let status: String
    let cash: Float
    let createdAt: String
    let isFavorite: Bool
}

struct BetDatabase {
    let supabase = SupabaseClient(
        supabaseURL: URL(string: "https://gffvdkcvgczxewyjaicg.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmZnZka2N2Z2N6eGV3eWphaWNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3MzE2MTgsImV4cCI6MjAxNjMwNzYxOH0.u-zJ1SECru9UwfhRsSMGEPfDZ9DzeaVe8BdvpGpUInE",
        options: SupabaseClientOptions(
            db: .init(
                schema: "public"
            )
        )
    )
    
    
    func getBets() async throws -> BetCollection {
        let response: [BetInDatabase] = try await supabase.database
            .from("bet")
            .select()
            .execute()
            .value
        
        let bets: [Bet] = response.map { bet in
            
            let sport = BetUtils.sportsList.first(where: { $0.name == bet.sport })!
            let status = BetUtils.statusList.first(where: { $0.name == bet.status })!
            
            
            return Bet(
                id: bet.id,
                name: bet.name,
                sport: Sport(name: sport.name, imageUrl: sport.imageUrl),
                competition: bet.competition,
                odd: bet.odd,
                status: BetStatus(name: status.name, colorHex: status.colorHex),
                cash: bet.cash,
                createdAt: bet.createdAt,
                isFavorite: bet.isFavorite
            )
        }
        return BetCollection(bets: bets)
    }
    
    
    func deleteBet(id: UUID) async throws {
        try await supabase.database
            .from("bet")
            .delete()
            .eq("id", value: id)
            .execute()
    }
    
    func addBet(bet: Bet) async throws -> Bet {
        let betFormatDb: BetInDatabase = BetInDatabase(
            id: bet.id,
            name: bet.name,
            sport: bet.sport.name,
            competition: bet.competition,
            odd: bet.odd,
            status: bet.status.name,
            cash: bet.cash,
            createdAt: bet.createdAt,
            isFavorite: bet.isFavorite
        )
        try await supabase.database
            .from("bet")
            .insert(betFormatDb)
            .execute()
        
        return bet
        
        
    }
    
    func updateBet(bet: Bet) async throws -> Bet {
        let betFormatDb: BetInDatabase = BetInDatabase(
            id: bet.id,
            name: bet.name,
            sport: bet.sport.name,
            competition: bet.competition,
            odd: bet.odd,
            status: bet.status.name,
            cash: bet.cash,
            createdAt: bet.createdAt,
            isFavorite: bet.isFavorite
        )
        try await supabase.database
            .from("bet")
            .update(betFormatDb)
            .eq("id", value: bet.id)
            .execute()
        
        return bet
        
        
    }
}
