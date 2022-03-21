//
//  Personne.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 14/02/2022.
//

// Sauvegarde git
import Foundation
import SwiftUI

class Personne : ObservableObject ,Codable, Identifiable, Hashable {
    
    //@ObservedObject var datas : Mesures
    
    var id:UUID = UUID()
    @Published var prenom: String = ""
    @Published var nom: String = ""
    var identite: String {
        get {
            return prenom + nom
        }
        set {
            //prenom + nom
        }
    }
    
    var poids: Double = 76
    
    //@Published var glycemie: [Glycemie] = []//:MesuresSucre = MesuresSucre()
    @Published var diabete: MesuresSucre = MesuresSucre()
    @Published var rapportsQuotidien : [RapportQuotidien] = [RapportQuotidien]()
    @Published var tension : Mesures = Mesures()
    //var pourCeJour : [RapportQotidien] = []
    
    //----------------------------
   
    enum CodingKeys: String,CodingKey {
        case id = "id"
        case prenom = "prenom"
        case nom = "nom"
        case poids = "poids"
        //case glycemie = "glycemie"
        case diabete = "diabete"
        case rapportsQuotidien = "rapportsQuotidien"
        //case rapportsQuotidien = "rapports"
        case tension = "tension"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(nom)
        hasher.combine(prenom)
    }
    static func == (lhs: Personne, rhs: Personne) -> Bool {
           return lhs.nom == rhs.nom && lhs.prenom == rhs.prenom
       }
    
    required init(from decoder: Decoder) throws {
       //tension = Mesures()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        prenom = try container.decode(String.self, forKey: .prenom)

        nom = try container.decode(String.self, forKey: .nom)

        poids = try container.decode(Double.self, forKey: .poids)
        // Utiliser json
        //glycemie = try container.decode([Glycemie].self, forKey: .glycemie)
        diabete = try container.decode(MesuresSucre.self, forKey: .diabete)
        rapportsQuotidien = try container.decode([RapportQuotidien].self, forKey: .rapportsQuotidien)
        //rapportsQuotidien = try container.decode(Rapport.self, forKey: .rapportsQuotidien)
        tension = try container.decode(Mesures.self, forKey: .tension)
        
        // Utiliser userdefault
        
    }
    
    init(nom:String,prenom: String){
        self.nom = nom
        self.prenom = prenom
        
        //recallSucre()
        //recallTension()
        //recallRapports()
    }

    
    init(){
        //recallIdentity()
        /*
        if !recallFromFile(){
            
        }
        
        recallSucre()
        recallTension()
        recallRapports()
        */
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)

        try container.encode(prenom, forKey: .prenom)
        try container.encode(nom, forKey: .nom)

        try container.encode(poids, forKey: .poids)
        //try container.encode(glycemie, forKey: .glycemie)
        try container.encode(diabete, forKey: .diabete)
        try container.encode(rapportsQuotidien, forKey: .rapportsQuotidien)
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
        
        glycemie = glycemie.sorted(by: {
            $0.date < $1.date
        })
         */
    }
    
    // Attention, utiliser plutot l'acces par Users
    func effaceIdentite(){
        prenom = ""
        nom = ""
    }
    
    func stringIdentity() ->String{
        return prenom + "_" + nom
    }
    
    // MARK: - gérer les mesures
    func removeRapport(at indexSet: IndexSet){
        rapportsQuotidien.remove(atOffsets: indexSet)
        //savePersonne()
    }
    
    func addRapport(rapport:RapportQuotidien){
        let tailleMesures = rapportsQuotidien.count
        if tailleMesures > NOMBRE_MAX_MESURES_SUCRE {
            rapportsQuotidien.removeFirst()
        }
        rapportsQuotidien.append(rapport)
        //savePersonne()
    }
    
    func addDiabete(mesure:MesureSucre){
        let tailleMesures = diabete.sucre.count
        if tailleMesures > NOMBRE_MAX_MESURES_SUCRE {
            diabete.sucre.removeFirst()
        }
        diabete.sucre.append(mesure)
    }
    func addTension(mesure:Mesure){
        let tailleMesures = tension.maTension.count
        if tailleMesures > NOMBRE_MAX_MESURES_TENSION {
            tension.maTension.removeFirst()
        }
        tension.maTension.append(mesure)
    }
    

    //-------------------------------------------
    //-------Gestion des fichiers ----------------
    
    // MARK: - Identitée
    //Enregistrer identité en local
    // Il s'agit de l'utilisateur courant
    // Attention, utiliser plutot l'acces par Users
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
    
    //------- Exportations-----
    func exportDatas(name : String) {
            // Exportation des donnees
    }

    //-----------  fchiers locaux------
    func saveSucre(){
        let ident = stringIdentity() + SUCRE
        let defaults = UserDefaults.standard
        //defaults.set(diabete, forKey: "diabete")//------------------------------------------------------
        // enregistrement sur fichier
        save2File()
    }
    
    func recallSucre(){
        let ident = stringIdentity() + SUCRE
        let userdefault = UserDefaults.standard
        diabete = userdefault.object(forKey: "diabete") as? MesuresSucre ?? MesuresSucre()
        recallFromFile()
    }
    
    
    func saveRapports(){
        let ident = stringIdentity() + RAPPORT
        let defaults = UserDefaults.standard
        //defaults.set(rapportsQuotidien, forKey: "rapportsQuotidien") //-----------------------------------------
        // enregistrement sur fichier
        save2File()
    }
    func recallRapports() {
        let ident = stringIdentity() + RAPPORT
        let userdefault = UserDefaults.standard
        rapportsQuotidien = userdefault.object(forKey: "rapportsQuotidien") as? [RapportQuotidien] ?? []
        recallFromFile()
    }
    func saveTension(){
        let ident = stringIdentity() + TENSIONS
        let defaults = UserDefaults.standard
        //defaults.set(tension, forKey: "tension") //------------------------------------------
        // enregistrement sur fichier
        save2File()
    }
    
    func recallTension(){
        let ident = stringIdentity() + TENSIONS
        let userdefault = UserDefaults.standard
        tension = userdefault.object(forKey: "tension") as? Mesures ?? Mesures()
        recallFromFile()
    }
    

    
    
    //MARK: Sauvegarde sur fichier externe
     // Enregistrer les données sur un fichier externe
    //nom: String
    func savePersonne(){
        if let aSauver = self.toJson(){
            let ident = stringIdentity()
            let nomFichier = ident + ".json"
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
    func saveSucreFile()  {
        if let aSauver = sucreToJson(){
            let ident = stringIdentity()
            let nomFichier = ident + "_" + NOM_FICHIER_SUCRE + ".json"
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
    func sucreToJson() -> String? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(diabete),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
    
    
    
    //----------------------------------
    
    
    // lire un fichier s'il existe
    // On lui passe un nom : identitée + nom type du fichier (NOM_FICHIER_RAPPORT)...
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
    
    
    // MARK: - Sauvegarde personne
    
    func toJson() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encoded = try? encoder.encode(self),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
    
    func rapportToJson() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encoded = try? encoder.encode(self.rapportsQuotidien),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
    
    
    
    // MARK: - Sauvegarde en json
    
    // Enregistrer les données sur un fichier externe
    func save2File()  {
        let ident = stringIdentity()
        if let aSauver = self.toJson(){
            let nomFichier = ident + ".json"
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
    
    // Récupérer un fichier externe et utiliser ses valeurs pour la présentation
    func  recallFromFile()->Bool  {
        // A écrire
        guard  let jsonString = readFromFile() else {
            return false
        }
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(Personne.self, from: jsonData)
            //self.glycemie = result.glycemie
            self.diabete = result.diabete
            self.tension = result.tension
            self.rapportsQuotidien = result.rapportsQuotidien
            self.poids = result.poids
            
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    // lire un fichier s'il existe
    func readFromFile() -> String? {
        let ident = stringIdentity()
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(ident + ".json")
        do {
            let retour = try String(contentsOf: url, encoding: .utf8)
            return retour
        }  catch {
            print(error.localizedDescription)
            return nil
        }
    }
 
    // Exopr to airdrop
    func toAirdrop(mesuresDe: String = TENSIONS)->String {
        var content = ""
        if mesuresDe == TENSIONS {
            let sortie = tension.toJson() ?? ""
            return sortie
        }
        if mesuresDe == SUCRE {
            let sortie = diabete.toJson() ?? ""
            return sortie
        }
        if mesuresDe == RAPPORT {
            let sortie = rapportToJson() ?? ""
            return sortie
        }
        return content
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

var testPersonne = Personne()
