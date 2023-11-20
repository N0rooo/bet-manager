
import SwiftUI

struct NewBetView: View {
    
    @Binding var bets: [Bet]
    
    @State var name: String = ""
    @State var image: String = ""
    @State var sport: String = ""
    @State var odd: Double = 0.0 // This property was not used in your view
    
    let sportsList: [String] = [
        "Football", "Tennis", "Basketball"
    ]
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Ajouter un paris")) {
                    TextField("Nom du paris", text: $name)
                    TextField("Lien de l'image", text: $image)
                    Picker(selection: $sport, label: Text("Sport")) {
                        ForEach(sportsList, id: \.self) { sport in
                            Text(sport)
                        }
                    }
                    TextField("Cote", value: $odd, formatter: NumberFormatter())
                }
            }
            .padding(.top, 20)
            
            Spacer()
            
            Button(action: {
                bets.append(Bet(name: name, image: image, sport: sport, odd: odd))
                name = ""
                image = ""
                sport = ""
                odd = 0.0
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
        NewBetView(bets: .constant([]))
    }
}
