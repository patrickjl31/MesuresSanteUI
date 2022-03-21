//
//  MesuresSucre.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 13/02/2022.
//

import Foundation
import SwiftUI


class MesuresSucre: ObservableObject, Codable, Identifiable {
    
    
    @Published var sucre : [MesureSucre] = []
    /*
    desMesures.sorted(by: {
        $0.dateMesure < $1.dateMesure
    })//[]
    */
    // Pour rendre codable et decodable
    enum  CodingKeys: String, CodingKey {
        case sucre
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sucre = try values.decode([MesureSucre].self, forKey: .sucre)
        sucre = sucre.sorted(by: {
            $0.dateMesure < $1.dateMesure
        })
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sucre, forKey: .sucre)
    }
    
    init() {
        /*
        if !recallFromFile(){
            if let anciennesMesures = recall(){
                sucre = anciennesMesures
            }
            else {
                sucre = sucre.sorted(by: {
                    $0.dateMesure < $1.dateMesure
                })
            }
        }
        */
    }
    
    //mutating
    func enregistrerMesure(leSucre: Double, date:Date){
        // On calcule la date et le moment de la journée
       
        //let date = Date()
        
        // On crée une nouvelle mesure et on lui affecte les valeurs
        var nouvelleMesure = MesureSucre(taux: leSucre, dateMesureS: date.toString(),dateMesure: Date())
        let infos = date.identDateAndMoment()
        nouvelleMesure.moment = infos.moment
        /*
        if let pm = formatter.string(from: date).split(separator: " ").last {
            nouvelleMesure.moment = String(pm)
        }
 */
        sucre.append(nouvelleMesure)
        sucre.sort {
            $0.dateMesure < $1.dateMesure
        }
        save()
    }
    
    
    func noMesures() -> Bool {
        return sucre.count == 0
    }
    
    func delete(item : IndexSet) {
        sucre.remove(atOffsets: item)
        save()
    }
    
    func deleteAll() {
        sucre = []
    }
    
    //MARK: - Calculer les courbes
    func courbes() -> (valSucre : [Double], dates: [Date], maxi : Double, mini:Double) {
        
        var duSucre : [Double] = []
        var date : [Date] = []

        if noMesures(){
            return (duSucre,date,0,0)
        }
        
        
        for elem in 0..<sucre.count {
            duSucre.append(sucre[elem].taux)
            date.append(sucre[elem].dateMesure)
        }
        //let maxi = max(diastolique.max()!,systolique.max()!)
        //let mini = min(diastolique.min()!, systolique.min()!)
        if let maxi = duSucre.max(), let mini = duSucre.min() {
            return (duSucre, date,maxi, mini)
        } else {
            return (duSucre, date,100, 0)
        }
    }
    
    func courbeFine(moment: [Moment]) -> (valSucre : [Double], dates: [Date], maxi : Double, mini:Double) {
        
        var duSucre : [Double] = []
        var date : [Date] = []

        if noMesures(){
            return (duSucre,date,0,0)
        }
        
        for elem in 0..<sucre.count {
            let momentCetElem = Moment(rawValue: sucre[elem].moment)
            if momentCetElem != nil {
                let aNoter = moment.contains(momentCetElem!)
                if aNoter {
                    duSucre.append(sucre[elem].taux)
                    date.append(sucre[elem].dateMesure)
                }
            }
        }

        if let maxi = duSucre.max(), let mini = duSucre.min() {
            return (duSucre, date,maxi, mini)
        } else {
            return (duSucre, date,7, 0)
        }
    }
    
    // Json : -encode maTension
    func toJson() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let encoded = try? encoder.encode(sucre),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
    
    
    // Sauvegardes
    func save() {
        let userdefault = UserDefaults.standard
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let encoded = try? encoder.encode(self){
            userdefault.set(encoded, forKey: SUCRE)
        }
    }
    
    func recall() -> [MesureSucre]? {
        let userdefault = UserDefaults.standard
        if let saved = userdefault.object(forKey: SUCRE) as? Data {
            let decoder = JSONDecoder()
            if let sucres = try? decoder.decode(MesuresSucre.self, from: saved) {
                return sucres.sucre
            }
        }
        return nil
    }
    
   //MARK: Sauvegarde sur fichier externe
    // Enregistrer les données sur un fichier externe
    func save2File()  {
        if let aSauver = self.toJson(){
            let nomFichier = NOM_FICHIER_SUCRE + ".txt"
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
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(NOM_FICHIER_SUCRE + ".json")
        do {
            let retour = try String(contentsOf: url, encoding: .utf8)
            return retour
        }  catch {
            print("Error lecture sucre") //(error.localizedDescription)
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
            let result = try decoder.decode([MesureSucre].self, from: jsonData)
            self.sucre = result
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    
    
}


//MARK:  -Liste de mesures pour test

let tesSucres :[MesureSucre] = [
    MesureSucre(taux: 1.4, dateMesure: Date(timeIntervalSinceNow: -demiJour), moment: "AM"),
    MesureSucre(taux: 1.6, dateMesure: Date(timeIntervalSinceNow: -demiJour - nJours(n: 1)), moment: "PM"),
    MesureSucre(taux: 1.4, dateMesure: Date(timeIntervalSinceNow: -demiJour - nJours(n: 2)), moment: "AM"),
    MesureSucre(taux: 1.6, dateMesure: Date(timeIntervalSinceNow: -demiJour - nJours(n: 3)), moment: "PM"),
    
    MesureSucre(taux: 1.6, dateMesure: Date(timeIntervalSinceNow: -demiJour - nJours(n: 4)), moment: "PM")


]

var testSucre = MesuresSucre()
