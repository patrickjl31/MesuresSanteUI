//
//  MesureSucre.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 12/02/2022.
//

import Foundation

struct MesureSucre: Codable, Identifiable {
    var id:UUID = UUID()
    var taux: Double = 0
    var dateMesureS : String = ""
    var dateMesure: Date = Date()
    var itemMomentMesure : Int = 1
    var moment:String = ""
    
    
                        
    func toJson() -> String? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
}

enum Moment : String, CaseIterable{
    case reveil = "Réveil"
    case apresPetitDej = "Apres petit déjeuner"
    case avantDej = "Avanr déjeuner"
    case apresDej = "Après déjeuner"
    case avantDine = "Avant diner"
    case couche = "Couché"
}
enum MomentBrut : String, CaseIterable{
    case reveil
    case apresPetitDej
    case avantDej
    case apresDej
    case avantDine
    case couche
}

//let ListeMomentsSucre = ["Réveil", "Apres petit déjeuner", "Avanr déjeuner", "Après déjeuner", "Avant diné", "Couché"]
