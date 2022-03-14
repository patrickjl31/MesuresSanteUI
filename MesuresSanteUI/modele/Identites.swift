//
//  Identites.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 05/03/2022.
//

import Foundation

class Identites : Codable, ObservableObject {
    var id:UUID = UUID()
    @Published var liste : [identite] = []
    @Published var selected : Int = -1
    
    enum CodingKeys: String, CodingKey{
        case id, liste, selected
    }
    required init(from decoder: Decoder) throws {
       //tension = Mesures()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        liste = try container.decode([identite].self, forKey: .liste)
        
        // Utiliser userdefault
        
    }
    
    init(){
        let lesListes = readFromFile() ?? ""
        //print(lesListes)
        if lesListes != "" {
            liste = jsonToidentites(sJson: lesListes) ?? [identite]()
        } else {
            liste = [identite]()
        }
        
        selected = UserDefaults.standard.integer(forKey: "SELECTED_USER")
        //print(selected)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)

        try container.encode(liste, forKey: .liste)
        try container.encode(selected, forKey: .selected)

    }
    
    func addIdentite(nom: String, prenom:String) {
        if !exist(nom: nom, prenom: prenom){
            let nomSansBlancs = nom.trimmingCharacters(in: .whitespacesAndNewlines)
            let prenomSansBlancs = prenom.trimmingCharacters(in: .whitespacesAndNewlines)
            let newPersonne = identite(nom: nomSansBlancs, prenom: prenomSansBlancs)
            liste.append(newPersonne)
            selected = liste.count - 1
            // On enregistre
            save2File()
        }
        
    }
    //change l'identité de l'utilisateur courant
    func changeIdentityFrom(nom: String , prenom: String, toNom: String , toPrenom: String){
        let nomSansBlancs = nom.trimmingCharacters(in: .whitespacesAndNewlines)
        let prenomSansBlancs = prenom.trimmingCharacters(in: .whitespacesAndNewlines)
        let index = getUser(nom: nomSansBlancs, prenom: prenomSansBlancs)
        if index > -1 {
            let toNomSansBlancs = toNom.trimmingCharacters(in: .whitespacesAndNewlines)
            let toPrenomSansBlancs = toPrenom.trimmingCharacters(in: .whitespacesAndNewlines)
            liste[index].nom = toNomSansBlancs
            liste[index].prenom = toPrenomSansBlancs
        }
    }
    
    func getUser(nom: String, prenom:String)->Int{
        for index in 0..<liste.count {
            if (liste[index].nom == nom) && (liste[index].prenom == prenom){
                return index
            }
        }
        return -1
    }
    
    func exist(nom: String, prenom:String)->Bool{
        
        return getUser(nom: nom, prenom: prenom) > -1
    }
    
    func setSelectedTo(val : Int) {
        if (val > -1) && (val < liste.count) {
            selected = val
            UserDefaults.standard.set(self.selected, forKey: "SELECTED_USER")
        }
    }
    func SelectToNom(nom: String, prenom:String)->Bool{
        let index = getUser(nom: nom, prenom: prenom)
        if index > -1 {
            selected = index
            return true
        }
        return false
    }
    func isSelected(nom: String, prenom:String)->Bool{
        let index = getUser(nom: nom, prenom: prenom)
        if index == selected {
            return true
        }
        return false
    }
        
    
    // MARK: - enregistrements
    
    
    func toJson() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encoded = try? encoder.encode(liste),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
    // Enregistrer les données sur un fichier externe
    func save2File()  {
        //let ident = stringIdentity()
        if let aSauver = self.toJson(){
            let nomFichier = "liste_utilisateurs.json"
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let url = path[0].appendingPathComponent(nomFichier)
            do {
                //let retour = try String(contentsOf: url, encoding: .utf8)
                try aSauver.write(to: url, atomically: true, encoding: .utf8)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    // lire un fichier s'il existe
    func recallFile() {
        let lesListes = readFromFile() ?? ""
        //print(lesListes)
        if lesListes != "" {
            liste = jsonToidentites(sJson: lesListes) ?? [identite]()
        } else {
            liste = [identite]()
        }
    }
    
    func readFromFile() -> String? {
        //let ident = stringIdentity()
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("liste_utilisateurs.json")
        do {
            let retour = try String(contentsOf: url, encoding: .utf8)
            return retour
        }  catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func jsonToidentites(sJson:String) -> [identite]? {
        let jsonData = Data(sJson.utf8)
        let decoder = JSONDecoder()
        if let patient = try? decoder.decode([identite].self, from: jsonData){
            //let patient : Patient
            return patient
        }
        return nil
    }
    
    
}
