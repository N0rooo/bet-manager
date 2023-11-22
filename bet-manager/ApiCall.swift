//
//  ApiCall.swift
//  bet-manager
//
//  Created by Thomas Aubert on 22/11/2023.
//

import SwiftUI

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
                    print(self.sportTitles)
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
