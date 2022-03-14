//
//  Identite.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 05/03/2022.
//

import Foundation

class identite: Codable, Identifiable, ObservableObject,Hashable{
    var id:UUID = UUID()
    @Published var nom : String
    @Published var prenom : String
    @Published var personne : Personne
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(nom)
        hasher.combine(prenom)
    }
    static func == (lhs: identite, rhs: identite) -> Bool {
           return lhs.nom == rhs.nom && lhs.prenom == rhs.prenom
       }
    
    enum CodingKeys: String, CodingKey{
        case nom, prenom, id, personne
    }
    required init(from decoder: Decoder) throws {
       //tension = Mesures()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        nom = try container.decode(String.self, forKey: .nom)
        prenom = try container.decode(String.self, forKey: .prenom)
        personne = try container.decode(Personne.self, forKey: .personne)
        // Utiliser userdefault
        
    }
    
    init(nom:String, prenom : String){
        self.nom = nom
        self.prenom = prenom
        self.personne = Personne(nom: nom, prenom: prenom)
    }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)

        try container.encode(nom, forKey: .nom)
        try container.encode(prenom, forKey: .prenom)

    }
    
    
    
    
    

}
