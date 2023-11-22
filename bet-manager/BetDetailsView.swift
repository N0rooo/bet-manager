//
//  BetDetailsView.swift
//  bet-manager
//
//  Created by Thomas Aubert on 21/11/2023.
//

import SwiftUI

struct BetDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ViewModel()
    @ObservedObject var bet: Bet
    
    @State private var editedName: String
    @State private var editedCash: String
    @State private var editedOdd: String
    @State private var isEditingStatus: Bool = false
    @State private var isFavorite: Bool = false
    @State private var editedStatus: BetStatus
    @State private var editedSport: Sport
    @State private var editedCompetition: String
    

    init(bet: Bet) {
        self.bet = bet
        _editedName = State(initialValue: bet.name)
        _editedCash = State(initialValue: String(bet.cash))
        _editedOdd = State(initialValue: String(bet.odd))
        _isFavorite = State(initialValue: bet.isFavorite)
        _editedStatus = State(initialValue: bet.status)
        _editedSport = State(initialValue: bet.sport)
        _editedCompetition = State(initialValue: bet.competition)
    }
    
    var body: some View {
        ScrollView{
            VStack {
                AsyncImage(url: URL(string: editedSport.imageUrl)) { image in
                    image.resizable()
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
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
                        Text("Sport")
                            .foregroundColor(.gray)
                        
                        Picker(selection: $editedSport, label: Text("Sport")) {
                            ForEach(BetUtils.sportsList, id: \.self) { sport in
                                Text(sport.name)
                            }
                            
                        }
                    }.padding(.top, 10)
                    VStack(alignment: .leading) {
                        Text("Compétition")
                            .foregroundColor(.gray)
                        
                        Picker(selection: $editedCompetition, label: Text("Compétition")) {
                            ForEach(viewModel.sportTitles, id: \.self) { title in
                                Text(title)
                            }
                        }
                    }.padding(.top, 10)
                    
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
                viewModel.fetch()
                editedName = bet.name
                editedCash = String(bet.cash)
                editedOdd = String(bet.odd)
                editedStatus = bet.status
                isFavorite = bet.isFavorite
                editedSport = bet.sport
                editedCompetition = bet.competition
            }
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
        bet.sport = editedSport
        bet.competition = editedCompetition
        
    }
}

struct BetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BetDetailsView(bet: Bet.previewBet[0])
    }
}
