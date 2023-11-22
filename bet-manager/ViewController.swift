//
//  File.swift
//  bet-manager
//
//  Created by Thomas Aubert on 22/11/2023.
//

import Foundation

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }

    func callAPI() {
        let apiUrlString = "https://api.the-odds-api.com/v4/sports/?all=true&apiKey=19972cac78e0f8ee942ace4839a22d57"

        // Créer une URL à partir de la chaîne d'URL
        guard let apiUrl = URL(string: apiUrlString) else {
            print("L'URL de l'API est incorrecte.")
            return
        }

        let session = URLSession.shared

        let task = session.dataTask(with: apiUrl) { (data, response, error) in
            if let error = error {
                print("Erreur lors de la requête : \(error.localizedDescription)")
                return
            }

            guard let responseData = data else {
                print("Aucune donnée renvoyée.")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                    print("Réponse de l'API : \(json)")
                }
            } catch {
                print("Erreur lors de la conversion des données JSON : \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}
