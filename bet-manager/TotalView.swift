//
//  TotalView.swift
//  bet-manager
//
//  Created by Thomas Aubert on 23/11/2023.
//

import SwiftUI

struct TotalView: View {
    var totalProfits: Float
    
    var body: some View {
        VStack {
            Text("Total :")
                .foregroundColor(.gray)
            HStack {
                Spacer()
                Text("\(totalProfits > 0 ? "+" : "") \(String(format: "%.2f", totalProfits)) €")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(getTextColor(for: totalProfits))
                Spacer()
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
}

