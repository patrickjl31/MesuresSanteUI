//
//  Users.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 25/02/2022.
//

import Foundation


class Users : Codable {
    var listePatients : [Personne] = []
    
    var patientCourant : Personne
    
    // Sauvegardes
    func save() {
        let userdefault = UserDefaults.standard
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let encoded = try? encoder.encode(self){
            userdefault.set(encoded, forKey: USERS)
        }
    }
    
    func recall() -> [Personne]? {
        let userdefault = UserDefaults.standard
        if let saved = userdefault.object(forKey: USERS) as? Data {
            let decoder = JSONDecoder()
            if let sucres = try? decoder.decode(Users.self, from: saved) {
                return sucres.listePatients
            }
        }
        return nil
    }
    
}
