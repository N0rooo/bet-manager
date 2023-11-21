//
//  BetDetailsView.swift
//  bet-manager
//
//  Created by Thomas Aubert on 21/11/2023.
//

import SwiftUI

struct BetDetailsView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var bet: Bet
    
    @State private var editedName: String
    @State private var editedCash: String
    @State private var editedOdd: String
    @State private var isEditingStatus: Bool = false
    @State private var isFavorite: Bool = false
    @State private var editedStatus: BetStatus
    
    init(bet: Bet) {
        self.bet = bet
        _editedName = State(initialValue: bet.name)
        _editedCash = State(initialValue: String(bet.cash))
        _editedOdd = State(initialValue: String(bet.odd))
        _isFavorite = State(initialValue: bet.isFavorite)
        _editedStatus = State(initialValue: bet.status)
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: bet.sport.imageUrl)) { image in
                image.resizable()
                    .clipShape(Circle())
            } placeholder: {
                Circle()
            }
            .frame(width: 150, height: 150)
            
            
            Picker(selection: $editedStatus, label: Text("Status")) {
                ForEach(BetUtils.statusList, id: \.self) { status in
                    Text(status.name)
                }
                
            }.border(editedStatus.color)
            
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Nom")
                        .foregroundColor(.gray)
                    
                    TextField("Nom", text: $editedName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("Mise")
                        .foregroundColor(.gray)
                    TextField("Mise", text: $editedCash)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.top, 10)
                
                VStack(alignment: .leading) {
                    Text("Cote")
                        .foregroundColor(.gray)
                    
                    TextField("Cote", text: $editedOdd)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.top, 10)
                
                HStack {
                    Text("Favori")
                        .foregroundColor(.gray)
                    
                    Toggle("", isOn: $isFavorite)
                        .toggleStyle(SwitchToggleStyle(tint: .yellow))
                }
                .padding(.top, 10)
                
                
            }
            .padding(.horizontal)
            
            Button(action: {
                applyChanges()
                dismiss()
                
            }, label: {
                Text("Modifier")
            }
            )
            
            .padding()
        }
        .padding()
        .navigationTitle(bet.name)
        .onAppear {
            
            editedName = bet.name
            editedCash = String(bet.cash)
            editedOdd = String(bet.odd)
            editedStatus = bet.status
            isFavorite = bet.isFavorite
        }
    }
    
    private func applyChanges() {
        bet.name = editedName
        if let cash = Float(editedCash) {
            bet.cash = cash
        }
        if let odd = Float(editedOdd) {
            bet.odd = odd
        }
        bet.isFavorite = isFavorite
        bet.status = editedStatus
        
    }
}

struct BetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BetDetailsView(bet: Bet.previewBet[0])
    }
}
