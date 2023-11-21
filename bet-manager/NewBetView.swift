
import SwiftUI
import UIKit

struct NewBetView: View {
    
    @Binding var bets: [Bet]
    @Binding var isPresented: Bool
    
    @State var name: String = ""
    @State var image: String = ""
    @State var sport: Sport = Sport(name: "Football", imageUrl: "https://media.istockphoto.com/id/610241662/fr/photo/ballon-de-football-isol%C3%A9-sur-fond-blanc.jpg?s=612x612&w=0&k=20&c=yulUStMmoLbwnNrLT8eNcN_IX4Af8eyPLKhHyOPwFjY=")
    @State var odd: String = ""
    @State var status: BetStatus = BetStatus(name: "En cours", color: .gray)
    @State var cash: String = ""
    
    
    var error: Bool = false
    
    
    let sportsList: [Sport] = [
        Sport(name: "Football", imageUrl: "https://media.istockphoto.com/id/610241662/fr/photo/ballon-de-football-isol%C3%A9-sur-fond-blanc.jpg?s=612x612&w=0&k=20&c=yulUStMmoLbwnNrLT8eNcN_IX4Af8eyPLKhHyOPwFjY="),
        Sport(name: "Tennis", imageUrl: "https://img.freepik.com/vecteurs-premium/illustration-balle-tennis-classique_308773-33.jpg"),
        Sport(name: "Basketball", imageUrl: "https://img.freepik.com/vecteurs-libre/ballon-basket-isole_1284-42545.jpg")
    ]
    
    
    
    let isError: Bool = false
    
    let statusList: [BetStatus] = [
        BetStatus(name: "En cours", color: .gray),
        BetStatus(name: "Gagné", color: .green),
        BetStatus(name: "Perdu", color: .red)
        // Ajoutez d'autres états au besoin
    ]
    
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Ajouter un paris")) {
                    TextField("Nom du paris", text: $name)
                    Picker(selection: $sport, label: Text("Sport")) {
                        ForEach(sportsList, id: \.self) { sport in
                            Text(sport.name)
                        }
                    }
                    TextField("Cote", text: $odd)
                    TextField("Mise", text: $cash)
                    Picker(selection: $status, label: Text("Status")) {
                        ForEach(statusList, id: \.self) { status in
                            Text(status.name)
                        }
                    }
                    
                }
            }
            .padding(.top, 20)
            
            Spacer()
            
            Button(action: {
                
                let date = Bet.formattedCurrentDate()
                if cash.isEmpty || odd.isEmpty {
                    return
                }
                else if let oddValue = Float(odd), let cashValue = Float(cash) {
                    bets.append(Bet(name: name, sport: sport, odd: oddValue, status: status, cash: cashValue, created_at: date))
                  
                    isPresented.toggle()
                } else {
                    return
                }
            }, label: {
                Text("Valider")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            })
            .padding()
            
        }
    }
}

struct NewBetView_Previews: PreviewProvider {
    static var previews: some View {
        NewBetView(bets: .constant([]), isPresented: .constant(false))
    }
}
