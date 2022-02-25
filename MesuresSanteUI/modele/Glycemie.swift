//
//  Glycemie.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 18/02/2022.
//

import Foundation

class Glycemie: Codable, Identifiable {
    var id : UUID = UUID()
    var date : Date = Date()
    var sucre:Double = 0.0
    
    
    init(jour:Date, duSucre: Double){
        self.date = jour
        self.sucre = duSucre
    }
    
    func toJson() -> String? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
    
    
}
