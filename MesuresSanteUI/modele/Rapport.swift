//
//  Rapport.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 14/02/2022.
//

import Foundation


class Rapport  {
    
    var id:UUID = UUID()
    //@Published var mesures: Mesures = Mesures()
    //@Published var mesuresSucre: MesuresSucre = MesuresSucre()
    @Published var rapports: [RapportQuotidien] = []
    
    
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
    
    
}
