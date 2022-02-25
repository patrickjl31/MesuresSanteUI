//
//  Mesures.swift
//  tension (iOS)
//
//  Created by patrick lanneau on 06/12/2020.
//

import Foundation
import SwiftUI


class Mesures: ObservableObject, Codable , Identifiable{
    
    @Published var maTension : [Mesure] = []
    //@Published var monSucre : [MesuresSucre] = []
    //@Published var monRapport : [RapportQotidien] = []
    //@Published var patient : Personne = Personne()
    
    //@Published var sucre : [MesureSucre] = []
    /*
    desMesures.sorted(by: {
        $0.dateMesure < $1.dateMesure 
    })//[]
    */
    // Pour rendre codable et decodable
    enum  CodingKeys: String, CodingKey {
        case maTension
        //case monSucre
        case monRapport
        case patient
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        maTension = try values.decode([Mesure].self, forKey: .maTension)
        maTension = maTension.sorted(by: {
            $0.dateMesure < $1.dateMesure
        })
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(maTension, forKey: .maTension)
    }
    
    init() {
        if !recallFromFile(){
            if let anciennesMesures = recall(){
                maTension = anciennesMesures
            }
            else {
                maTension = desMesures.sorted(by: {
                    $0.dateMesure < $1.dateMesure
                })
            }
        }
        
    }
    
    //mutating
    func enregistrerMesure(syst: Double, diast: Double, coeur: Double,date:Date){
        // On calcule la date et le moment de la journée
       
        //let date = Date()
        
        // On crée une nouvelle mesure et on lui affecte les valeurs
        var nouvelleMesure = Mesure(systolique: syst, distolique: diast, pulsation: coeur, dateMesurS: date.toString(),dateMesure: date)
      
        let infos = date.identDateAndMoment()
        nouvelleMesure.moment = infos.moment
        /*
        if let pm = formatter.string(from: date).split(separator: " ").last {
            nouvelleMesure.moment = String(pm)
        }
 */
        maTension.append(nouvelleMesure)
        maTension.sort {
            $0.dateMesure < $1.dateMesure 
        }
        save(nom: TENSIONS)
    }
    
    
    func noMesures() -> Bool {
        return maTension.count == 0
    }
    
    func delete(item : IndexSet) {
        maTension.remove(atOffsets: item)
        save(nom: TENSIONS)
    }
    
    func deleteAll() {
        maTension = []
    }
    
    //MARK: - Calculer les courbes
    func courbes() -> (systol:[Double], diastol: [Double], fCoeur : [Double], dates:[Date],maxi : Double, mini:Double) {
        if noMesures(){
            return ([],[],[],[],0,0)
        }
        var systolique : [Double] = []
        var diastolique : [Double] = []
        var cardio : [Double] = []
        var date : [Date] = []
        
        for elem in 0..<maTension.count {
            diastolique.append(maTension[elem].distolique)
            systolique.append(maTension[elem].systolique)
            cardio.append(maTension[elem].pulsation)
            date.append(maTension[elem].dateMesure)
        }
        //let maxi = max(diastolique.max()!,systolique.max()!)
        //let mini = min(diastolique.min()!, systolique.min()!)
        if let maxi = systolique.max(), let mini = diastolique.min() {
            return (systolique, diastolique, cardio, date, maxi, mini)
        } else {
            return (systolique, diastolique, cardio, date,100, 0)
        }
    }
    
    // MARK: - gestion fichiers
    // Json : -encode maTension
    func toJson() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let encoded = try? encoder.encode(maTension),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
    
    
    // Sauvegardes
    // Nom est la clef du nom de fichier
    func save(nom : String) {
        let userdefault = UserDefaults.standard
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let encoded = try? encoder.encode(self){
            userdefault.set(encoded, forKey: nom)
        }
    }
    
    func recall(nom:String = "") -> [Mesure]? {
        let userdefault = UserDefaults.standard
        if let saved = userdefault.object(forKey: TENSIONS) as? Data {
            let decoder = JSONDecoder()
            if let tensions = try? decoder.decode(Mesures.self, from: saved) {
                return tensions.maTension
            }
        }
        return nil
    }
    
   //MARK: Sauvegarde sur fichier externe
    // Enregistrer les données sur un fichier externe
    func save2File()  {
        if let aSauver = self.toJson(){
            let nomFichier = NOM_FICHIER_TENSIONS + ".json"
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
    func readFromFile() -> String? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(NOM_FICHIER_TENSIONS + ".json")
        do {
            let retour = try String(contentsOf: url, encoding: .utf8)
            return retour
        }  catch {
            print(error.localizedDescription)
            return nil
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
            let result = try decoder.decode([Mesure].self, from: jsonData)
            self.maTension = result
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    
    
}





//MARK: -Extension dates
extension Date {

    func toShortString() -> String {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "dd-MM-YY:hh-mm"
        return formatter.string(from: self)
    }
    func  soirOuMatin()->String {
        let formatter = DateFormatter()
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        // on récupère uniuement PM ou AM
        formatter.dateFormat = "a"
        return formatter.string(from: self)
    }
    // Récupérer la date et la demi journée
    func identDateAndMoment() -> (date:String, moment:String) {
        let jour = self.toShortString()
        let moment = self.soirOuMatin()
        return(jour,moment)
    }
    
}



//MARK:  -Liste de mesures pour test
func nJours(n:Double) -> Double {
    return n * 86400.0
}
let date = Date()
let demiJour:Double = 86400 / 2.0

let m1 = Mesure(systolique: 14, distolique: 10, pulsation: 65, dateMesure: date, moment: "PM")
let m2 = Mesure(systolique: 14, distolique: 10, pulsation: 65, dateMesure: Date(timeIntervalSinceNow: -demiJour), moment: "AM")

let desMesures: [Mesure] = [
    Mesure(systolique: 14, distolique: 10, pulsation: 65, dateMesure: Date(timeIntervalSinceNow: -demiJour), moment: "AM"),
    Mesure(systolique: 13, distolique: 8, pulsation: 60, dateMesure: date, moment: "PM"),
    Mesure(systolique: 12, distolique: 7, pulsation: 78, dateMesure: Date(timeIntervalSinceNow: -demiJour - nJours(n: 1)), moment: "AM"),
    Mesure(systolique: 16, distolique: 8, pulsation: 100, dateMesure: date - nJours(n: 1), moment: "PM"),
    Mesure(systolique: 11, distolique: 10, pulsation: 68, dateMesure: Date(timeIntervalSinceNow: -demiJour - nJours(n: 2)), moment: "AM"),
    Mesure(systolique: 12, distolique: 9, pulsation: 56, dateMesure: date - nJours(n: 2), moment: "PM"),
    Mesure(systolique: 13, distolique: 10, pulsation: 65, dateMesure: Date(timeIntervalSinceNow: -demiJour - nJours(n: 3)), moment: "AM"),
    Mesure(systolique: 17, distolique: 11, pulsation: 98, dateMesure: date - nJours(n: 3), moment: "PM"),
    Mesure(systolique: 11, distolique: 7, pulsation: 65, dateMesure: Date(timeIntervalSinceNow: -demiJour - nJours(n: 4)), moment: "AM"),
    Mesure(systolique: 12, distolique: 8, pulsation: 65, dateMesure: date - nJours(n: 4), moment: "PM"),
    
    Mesure(systolique: 14, distolique: 5.4, pulsation: 78, dateMesure: Date(timeIntervalSinceNow: -demiJour - nJours(n: 5)), moment: "AM"),
    Mesure(systolique: 18, distolique: 6.3, pulsation: 84, dateMesure: date - nJours(n: 5), moment: "PM"),
    Mesure(systolique: 12, distolique: 8.3, pulsation: 65, dateMesure: Date(timeIntervalSinceNow: -demiJour - nJours(n: 6)), moment: "AM"),
    Mesure(systolique: 13, distolique: 9.2, pulsation: 46, dateMesure: date - nJours(n: 6), moment: "PM"),
    Mesure(systolique: 10, distolique: 7.5, pulsation: 86, dateMesure: Date(timeIntervalSinceNow: -demiJour - nJours(n: 7)), moment: "AM"),
    Mesure(systolique: 14, distolique: 6.8, pulsation: 78, dateMesure: date - nJours(n: 7), moment: "PM")
]

var testMesures: Mesures = Mesures()
//testMesures.sort{$0.dateMesure < $1.dateMesure }

//testMesures.maTension = desMesures

