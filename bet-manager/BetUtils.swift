//
//  BetUtils.swift
//  bet-manager
//
//  Created by Thomas Aubert on 21/11/2023.
//

import SwiftUI

class BetUtils {
}


extension BetUtils {
    static let sportsList: [Sport] = [
        Sport(name: "Football", imageUrl: "https://media.istockphoto.com/id/610241662/fr/photo/ballon-de-football-isol%C3%A9-sur-fond-blanc.jpg?s=612x612&w=0&k=20&c=yulUStMmoLbwnNrLT8eNcN_IX4Af8eyPLKhHyOPwFjY="),
        Sport(name: "Tennis", imageUrl: "https://img.freepik.com/vecteurs-premium/illustration-balle-tennis-classique_308773-33.jpg"),
        Sport(name: "Basketball", imageUrl: "https://img.freepik.com/vecteurs-libre/ballon-basket-isole_1284-42545.jpg")
    ]
    
    static let statusList: [BetStatus] = [
        BetStatus(name: "En cours", color: .gray),
        BetStatus(name: "Gagné", color: .green),
        BetStatus(name: "Perdu", color: .red)
    ]
}
    
