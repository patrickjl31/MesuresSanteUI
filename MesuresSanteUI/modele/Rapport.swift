//
//  Rapport.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 14/02/2022.
//

import Foundation


class Rapport:Codable ,Identifiable {
    
    var id:UUID = UUID()
    
    @Published var rapports: [RapportQuotidien] = []
    
    
     enum CodingKeys: String,CodingKey {
         case id = "id"
         case rapports = "rapports"
         
     }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rapports = try values.decode([RapportQuotidien].self, forKey: .rapports)
        rapports = rapports.sorted(by: {
            $0.date < $1.date
        })
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rapports, forKey: .rapports)
    }
    
    // MARK: - gestion fichiers
    // Json : -encode maTension
    func toJson() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let encoded = try? encoder.encode(rapports),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
    
    /*
    func saveUserDef(){
        let defaults = UserDefaults.standard
        let encoded = toJson()
        defaults.set(encoded, forKey: "Rapport")
    }
    func recallUserDef(){
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: "Rapport") as? Data {
            let decoder = JSONDecoder()
            if let loadedRapport = try? decoder.decode(Rapport.self, from: savedPerson) {
                print(rapports[0])
            }
        }
    }
    */
    
}
