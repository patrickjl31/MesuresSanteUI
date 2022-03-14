//
//  Mesure.swift
//  tension (iOS)
//
//  Created by patrick lanneau on 06/12/2020.
//

import Foundation

struct Mesure: Codable, Identifiable, Hashable {
    var id:UUID = UUID()
    var systolique: Double = 0
    var distolique:Double = 0
    var pulsation : Double = 0
    var oxygene : Double = 95.0
    var dateMesurS : String = ""
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
