
import SwiftUI
import UIKit

class ViewModel: ObservableObject {
    @Published var sportTitles: [String] = []
    
    func fetch() {
        guard let url = URL(string: "https://api.the-odds-api.com/v4/sports/?all=true&apiKey=19972cac78e0f8ee942ace4839a22d57") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error during data task: \(error!)")
                return
            }
            
            do {
                let sports = try JSONDecoder().decode([SportApi].self, from: data)
                DispatchQueue.main.async {
                    self.sportTitles = sports.map { $0.title }
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

struct NewBetView: View {
    
    @ObservedObject var betCollection: BetCollection
    @Binding var isPresented: Bool
    
    @State var name: String = ""
    @State var image: String = ""
    @StateObject var viewModel = ViewModel()
    
    @State var competition: String = ""
    
    @State var sport: Sport = Sport(name: "Football", imageUrl: "https://media.istockphoto.com/id/610241662/fr/photo/ballon-de-football-isol%C3%A9-sur-fond-blanc.jpg?s=612x612&w=0&k=20&c=yulUStMmoLbwnNrLT8eNcN_IX4Af8eyPLKhHyOPwFjY=")
    
    @State var odd: String = ""
    @State var status: BetStatus = BetStatus(name: "En cours", color: .gray)
    @State var cash: String = ""
    
    var error: Bool = false
    let isError: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Ajouter un paris")) {
                    TextField("Nom du paris", text: $name)
                    Picker(selection: $sport, label: Text("Sport")) {
                        ForEach(BetUtils.sportsList, id: \.self) { sport in
                            Text(sport.name)
                        }
                        
                    }
                    
                    Picker(selection: $competition, label: Text("Compétition")) {
                        ForEach(viewModel.sportTitles, id: \.self) { title in
                            Text(title)
                        }
                    }
                    TextField("Cote", text: $odd)
                    TextField("Mise", text: $cash)
                    Picker(selection: $status, label: Text("Status")) {
                        ForEach(BetUtils.statusList, id: \.self) { status in
                            Text(status.name)
                        }
                    }
                    
                }
            }
            .padding(.top, 20)
            .onAppear{
                viewModel.fetch()
            }
            
            
            Spacer()
            
            Button(action: {
                let date = Bet.formattedCurrentDate()
                if cash.isEmpty || odd.isEmpty {
                    return
                }
                else if let oddValue = Float(odd), let cashValue = Float(cash) {
                    betCollection.bets.append(Bet(name: name, sport: sport, competition: competition, odd: oddValue, status: status, cash: cashValue, createdAt: date, isFavorite: false))
                    
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
        NewBetView(betCollection: BetCollection(bets: Bet.previewBet), isPresented: .constant(false))
        
    }
}
