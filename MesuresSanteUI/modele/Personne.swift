//
//  Personne.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 14/02/2022.
//

import Foundation
import SwiftUI

class Personne : ObservableObject ,Codable, Identifiable {
    
    //@ObservedObject var datas : Mesures
    
    var id:UUID = UUID()
    @Published var prenom: String = ""
    @Published var nom: String = ""
    
    var poids: Double = 76
    
    
    @Published var glycemie: [Glycemie] = []//:MesuresSucre = MesuresSucre()
    @Published var diabete: MesuresSucre = MesuresSucre()
    
    @Published var rapportsQuotidien : [RapportQuotidien] = []//selles:Int = 0
    @Published var tension : Mesures = Mesures()
    //var pourCeJour : [RapportQotidien] = []
    
   
    enum CodingKeys: CodingKey {
        case id,prenom, nom, poids,
        glycemie,diabete,tension
    }
    
    required init(from decoder: Decoder) throws {
       //tension = Mesures()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        prenom = try container.decode(String.self, forKey: .prenom)

        nom = try container.decode(String.self, forKey: .nom)

        poids = try container.decode(Double.self, forKey: .poids)
        // Utiliser json
        glycemie = try container.decode([Glycemie].self, forKey: .glycemie)
        diabete = try container.decode(MesuresSucre.self, forKey: .diabete)
        tension = try container.decode(Mesures.self, forKey: .tension)
        
        // Utiliser userdefault
        
    }
    
    init(){
        recallIdentity()
        recallSucre()
        recallTension()
        recallRapports()
        
    }
    
    /*
    tension = Mesures()
    diabete = MesuresSucre()
    recallIdentity()
    
    if let dusucre = recallSucre(){
        glycemie = dusucre
    }
    
    if !recallPersonne(nom: RAPPORT){
        if let anciennesMesures = recall(){
            rapportsQuotidien = anciennesMesures
        }
        else {
            rapportsQuotidien = rapportsQuotidien.sorted(by: {
                $0.date < $1.date
            })
        }
    }
*/
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)

        try container.encode(prenom, forKey: .prenom)
        try container.encode(nom, forKey: .nom)

        try container.encode(poids, forKey: .poids)
        try container.encode(glycemie, forKey: .glycemie)
        try container.encode(diabete, forKey: .diabete)
        try container.encode(tension, forKey: .tension)
        
    }
    
    // Ordonner les mesures selon la date
    func triMesures() {
        rapportsQuotidien = rapportsQuotidien.sorted(by: {
            $0.date < $1.date
        })
        tension.maTension = tension.maTension.sorted(by: {
            $0.dateMesure < $1.dateMesure
        })
        diabete.sucre = diabete.sucre.sorted(by: {
            $0.dateMesure < $1.dateMesure
        })
        /*
        glycemie = glycemie.sucre.sorted(by: {
            $0.date < $1.date
        })
        */
        glycemie = glycemie.sorted(by: {
            $0.date < $1.date
        })
         
    }
    
    func effaceIdentite(){
        prenom = ""
        nom = ""
    }
    
    func stringIdentity() ->String{
        return prenom + "_" + nom
    }
    
    func removeRapport(at indexSet: IndexSet){
        rapportsQuotidien.remove(atOffsets: indexSet)
        savePersonne(nom: RAPPORT)
    }
    
    func addRapport(rapport:RapportQuotidien){
        rapportsQuotidien.append(rapport)
        savePersonne(nom: RAPPORT)
    }
    
    func enregistrerGlycemie(sucre : Glycemie){
        glycemie.append(sucre)
        // On enregistre
        saveGlycemie2File()
    }
    //-------------------------------------------
    //-------Gestion des fichiers ----------------
    
    func exportDatas(name : String) {
        // Exportation des donnees
    }
    
    func saveIdentity(){
        let defaults = UserDefaults.standard
        defaults.set(nom, forKey: "Nom")
        defaults.set(prenom, forKey: "Prenom")
    }
    
    func recallIdentity(){
        let defaults = UserDefaults.standard
        nom = defaults.object(forKey:"Nom") as? String ?? ""
        prenom = defaults.object(forKey:"Prenom") as? String ?? ""
    }
    
    //-----------  fchiers locaux------
    func saveSucre(){
        let ident = stringIdentity() + SUCRE
        let defaults = UserDefaults.standard
        defaults.set(diabete, forKey: ident)
    }
    
    func recallSucre(){
        let ident = stringIdentity() + SUCRE
        let userdefault = UserDefaults.standard
        diabete = userdefault.object(forKey: ident) as? MesuresSucre ?? MesuresSucre()
    }
    
    
    func saveRapports(){
        let ident = stringIdentity() + RAPPORT
        let defaults = UserDefaults.standard
        defaults.set(rapportsQuotidien, forKey: ident)
    }
    func recallRapports() {
        let ident = stringIdentity() + TENSIONS
        let userdefault = UserDefaults.standard
        rapportsQuotidien = userdefault.object(forKey: ident) as? [RapportQuotidien] ?? []
    }
    func saveTension(){
        let ident = stringIdentity() + TENSIONS
        let defaults = UserDefaults.standard
        defaults.set(diabete, forKey: ident)
    }
    
    func recallTension(){
        let ident = stringIdentity() + SUCRE
        let userdefault = UserDefaults.standard
        tension = userdefault.object(forKey: ident) as? Mesures ?? Mesures()
    }
    

    
    
    //MARK: Sauvegarde sur fichier externe
     // Enregistrer les données sur un fichier externe
    func savePersonne(nom: String){
        if let aSauver = self.toJson(){
            let nomFichier = nom + ".json"
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
    
    
    //------------------------------------
    // Enregistrer les données de glycemiesur un fichier externe
    func saveGlycemie2File()  {
        if let aSauver = glycemieToJson(){
            let nomFichier = NOM_FICHIER_SUCRE + ".json"
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
    
    // Json : -encode maTension
    func glycemieToJson() -> String? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(glycemie),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
    
    
    
    //----------------------------------
    
    
    // lire un fichier s'il existe
    func readFromFile(nom : String) -> String? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(nom + ".json")
        do {
            let retour = try String(contentsOf: url, encoding: .utf8)
            return retour
        }  catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    func recallPersonne(nom : String)->Bool {
        guard  let jsonString = readFromFile(nom: nom) else {
            return false
        }
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode([RapportQuotidien].self, from: jsonData)
            self.rapportsQuotidien = result
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    func toJson() -> String? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(rapportsQuotidien),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
    
    
     
    
    
    
    
    
}

/*
var test:Personne = Personne()
var testRap : RapportQuotidien = RapportQuotidien(selles: 4,diurese: 1)
testRap.remarques = "knnn"
testRap.temperature = 37.5
testRap.diurese = 0.9
test.rapportsQuotidien = [testRap]



 var id = UUID()
 var date = Date()
 var selles : Int = 0
 var diurese: Double = 0.0 //pipi
 var douleur : Int = 0
 var temperature : Double = 37.9
 var etatCutane:String = ""
 var moral : String = ""
 var remarques : String = ""


func toTest(){
    Glycemie = testSucre
}
 

let testSucre : [Glycemie] = [
    Glycemie(jour: Date(), duSucre: 0.4),
    Glycemie(jour: date + (1 * demiJour), duSucre: 1.3),
    Glycemie(jour: date + (2 * demiJour), duSucre: 1.7),
    Glycemie(jour: date + (3 * demiJour), duSucre: 1.1),
    Glycemie(jour: date + (4 * demiJour), duSucre: 1.3),
    Glycemie(jour: date + (5 * demiJour), duSucre: 1.6),
    Glycemie(jour: date + (6 * demiJour), duSucre: 1.1),
    Glycemie(jour: date + (7 * demiJour), duSucre: 1.5),
    Glycemie(jour: date + (8 * demiJour), duSucre: 0.6),
    Glycemie(jour: date + (9 * demiJour), duSucre: 1.9),
    Glycemie(jour: date + (10 * demiJour), duSucre: 1.3),
    Glycemie(jour: date + (11 * demiJour), duSucre: 1.2)
    




]
 */
