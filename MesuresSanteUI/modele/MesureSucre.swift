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
