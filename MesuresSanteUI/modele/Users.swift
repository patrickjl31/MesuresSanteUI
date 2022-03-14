//
//  Users.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 25/02/2022.
//

import Foundation
import SwiftUI

class Users : Codable, ObservableObject {
    
    var id: UUID = UUID()
    
    @Published var nomCurrentUser: String = ""
    @Published var prenomCurrentUser: String = ""
    
    @Published var listeUsers : [Personne] //= []
    
    @Published var userCourant : Int = -1 //= Personne()
    
    var currentUser:Personne? {
        get{
            if (userCourant > -1) {
                return  listeUsers[userCourant]
            }
            return nil
        }
    }
    // MARK: - Fonctions
    
    enum CodingKeys: String, CodingKey {
        case id , nomCurrentUser, prenomCurrentUser, listeUsers, userCourant
    }
    
    required init(from decoder: Decoder) throws {
       //tension = Mesures()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        nomCurrentUser = try container.decode(String.self, forKey: .nomCurrentUser)
        prenomCurrentUser = try container.decode(String.self, forKey: .prenomCurrentUser)
        listeUsers = try container.decode([Personne].self, forKey: .listeUsers)
        userCourant = try container.decode(Int.self, forKey: .userCourant)
        
        //tests
        if listeUsers.count == 0 {
            userCourant = -1
            nomCurrentUser = ""
            prenomCurrentUser = ""
            saveIdentity()
        }

        // Utiliser userdefault
        
    }
    
    init() {
        let userdefault = UserDefaults.standard
        listeUsers = userdefault.object(forKey: USERS) as? [Personne] ?? [Personne]()
        //recall()
        recallIdentity()
        recallFile()
        if listeUsers.count == 0 {
            userCourant = -1
            nomCurrentUser = ""
            prenomCurrentUser = ""
            saveIdentity()
        }
        recallIdentity()
        
    }
    //MARK: - Fonctions d'encodage json
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(listeUsers, forKey: .listeUsers)

        try container.encode(userCourant, forKey: .userCourant)
       
        
    }
    
    
    
    func toJson() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encoded = try? encoder.encode(listeUsers),
           let jsonString = String(data: encoded, encoding: .utf8){
            return jsonString
        }
        return nil
    }
    
    //MARK: - Fonctions
    
    func setIndexCurrentUser(toIndex:Int){
        let maxi = listeUsers.count
        if (toIndex > -1)  && (toIndex < maxi){
            userCourant = toIndex
            nomCurrentUser = listeUsers[userCourant].nom
            prenomCurrentUser = listeUsers[userCourant].prenom
        }
        saveIdentity()
    }
    
    func getCurrentUser()->Personne?{
        if userCourant > -1 {
            return listeUsers[userCourant]
        }
        return nil
    }
    
    // MARK: - Gestion des utilisateurs
    
    func addNewUser(nom: String , prenom: String){
        let nomSansBlancs = nom.trimmingCharacters(in: .whitespacesAndNewlines)
        let prenomSansBlancs = prenom.trimmingCharacters(in: .whitespacesAndNewlines)
        if getUserBy(nom: nomSansBlancs, prenom: prenomSansBlancs) < 0 {
            let newUser = Personne(nom: nomSansBlancs, prenom: prenomSansBlancs)
            //newUser.nom = nom
            //newUser.prenom = prenom
            listeUsers.append(newUser)
            userCourant = listeUsers.count - 1
            nomCurrentUser = nomSansBlancs
            prenomCurrentUser = prenomSansBlancs
            saveIdentity()
            save()
            save2File()
            //let temp = toJson()
            //print(temp)
        }
    }
    
    func removeUser(nom: String , prenom: String) {
        let nomSansBlancs = nom.trimmingCharacters(in: .whitespacesAndNewlines)
        let prenomSansBlancs = prenom.trimmingCharacters(in: .whitespacesAndNewlines)
        var indexToDelete: Int = -1
        for index in 0..<listeUsers.count {
            if (listeUsers[index].nom == nomSansBlancs) && (listeUsers[index].prenom == prenomSansBlancs) {
                indexToDelete = index
            }
        }
        if indexToDelete == userCourant {
            userCourant = -1
        }
        if userCourant > indexToDelete{
            userCourant = userCourant - 1
        }
        saveIdentity()
        listeUsers.remove(at: indexToDelete)
        save2File()
    }
    
    func removeUserAtIndex(index: IndexSet) {
        if index.contains(userCourant) {
            userCourant = -1
        }
        listeUsers.remove(atOffsets: index)
        save2File()
    }
    
    // Renvoie l'index de l'utilisateur de nom nom dans la liste des utilisateurs connus
    func getUserBy(nom : String, prenom : String)->Int{
        if listeUsers.count < 1 {
            return -1
        }
        for index in 0..<listeUsers.count {
            let patient:Personne = listeUsers[index]
            if (patient.nom == nom) && (patient.prenom == prenom){
                return index
            }
        }
        return -1
    }
    
    func isCurrentUser(nom:String, prenom : String)->Bool {
        guard let courant = getCurrentUser() else {return false}
        return (courant.nom == nom) && (courant.prenom == prenom)
    }
    func setCurrentUser(nom: String , prenom: String) {
        let nomSansBlancs = nom.trimmingCharacters(in: .whitespacesAndNewlines)
        let prenomSansBlancs = prenom.trimmingCharacters(in: .whitespacesAndNewlines)
        let place = getUserBy(nom: nomSansBlancs, prenom: prenomSansBlancs)
        if place < 0 {
            //Creation ?
            addNewUser(nom: nomSansBlancs, prenom: prenomSansBlancs)
            userCourant = listeUsers.count - 1
             nomCurrentUser = nomSansBlancs
             prenomCurrentUser = prenomSansBlancs
             saveIdentity()
             save()
            save2File()
            
        }else {
           userCourant = place
            nomCurrentUser = nomSansBlancs
            prenomCurrentUser = prenomSansBlancs
            saveIdentity()
            save()
            save2File()
        }
        
    }
    
    //change l'identité de l'utilisateur courant
    func changeIdentityTo(nom: String , prenom: String){
        let nomSansBlancs = nom.trimmingCharacters(in: .whitespacesAndNewlines)
        let prenomSansBlancs = prenom.trimmingCharacters(in: .whitespacesAndNewlines)
        if userCourant > -1 {
            let user = listeUsers[userCourant]
            user.nom = nomSansBlancs
            user.prenom = prenomSansBlancs
            nomCurrentUser = nomSansBlancs
            prenomCurrentUser = prenomSansBlancs
            saveIdentity()
            save()
            save2File()
        }
    }
    
    // change les noms et prénome d'un utiliateur
    func changeIdentityFrom(nom: String , prenom: String, toNom: String, toPrenom:String){
        let nomSansBlancs = nom.trimmingCharacters(in: .whitespacesAndNewlines)
        let prenomSansBlancs = prenom.trimmingCharacters(in: .whitespacesAndNewlines)
        let tonomSansBlancs = toNom.trimmingCharacters(in: .whitespacesAndNewlines)
        let toprenomSansBlancs = toPrenom.trimmingCharacters(in: .whitespacesAndNewlines)
        let place = getUserBy(nom: nomSansBlancs, prenom: prenomSansBlancs)
        if place > -1 {
            let user = listeUsers[place]
            user.nom = tonomSansBlancs
            user.prenom = toprenomSansBlancs
            userCourant = place
            saveIdentity()
            save()
            save2File()
        }
    }
    
    
   
    
    // MARK: - Tests
    func existCurrentUser()->Bool{
        if listeUsers.count < 1 {
            return false
        }
        return userCourant > -1
    }
    
    // MARK: - Identitée
    //Enregistrer identité en local
    // Il s'agit de l'utilisateur courant
    
    func saveIdentity(){
        let defaults = UserDefaults.standard
        defaults.set(nomCurrentUser, forKey: "Nom")
        defaults.set(prenomCurrentUser, forKey: "Prenom")
        defaults.set(userCourant, forKey: "userCourant")
    }
    
    func recallIdentity(){
        let defaults = UserDefaults.standard
        nomCurrentUser = defaults.object(forKey:"Nom") as? String ?? ""
        prenomCurrentUser = defaults.object(forKey:"Prenom") as? String ?? ""
        userCourant = defaults.object(forKey: "userCourant") as? Int ?? -1
    }
    
    // MARK: - enregistrement des mesures
    func addMesureTension(tension : Mesure){
        if userCourant > -1 {
            let patient = listeUsers[userCourant]
            patient.tension.maTension.append(tension)
            //on trie
            patient.triMesures()
            //patient.saveTension()
            save2File()
            print("Add tension en position \(patient.tension.maTension.count)")
        }
    }
    /*
    func enregistrerTension(){
        if userCourant > -1 {
            let patient = listeUsers[userCourant]
            
            patient.saveTension()
            save2File()
        }
    }
     */
    func addMesureSucre(sucre : MesureSucre){
        if userCourant > -1 {
            let patient = listeUsers[userCourant]
            patient.diabete.sucre.append(sucre)
            //on trie
            patient.triMesures()
            //patient.saveSucre()
            save2File()
            print("Add sucre en position \(listeUsers.count)")
        }
    }
    /*
    func enregistrerSucre(){
        if userCourant > -1 {
            let patient = listeUsers[userCourant]
            patient.saveSucre()
            save2File()
        }
    }
     */
    
    func addMesureRapport(rapport : RapportQuotidien){
        if userCourant > -1 {
            let patient = listeUsers[userCourant]
            patient.rapportsQuotidien.append(rapport)
            //on trie
            patient.triMesures()
            //patient.saveRapports()
            save2File()
            print("Add rapport en position \(listeUsers.count)")
        }
    }
    
    /*
    func enregistrerRapport(){
        if userCourant > -1 {
            let patient = listeUsers[userCourant]
            patient.saveRapports()
            save2File()
        }
    }
     */
    
    // MARK: - Remove mesures
    func removeMesureSucre(atIndex: IndexSet ){
        guard let index = atIndex.first else {return}
        print("remove : \(index)")
        if (userCourant > -1) && (index > -1) {
            let user:Personne = listeUsers[userCourant]
            let nombreMesures:Int = user.diabete.sucre.count
            if (nombreMesures > 0) && (index < nombreMesures){
                user.diabete.sucre.remove(at: index)
                save2File()
            }
        }
    }
    /*
    func removeMesureSucre1(atIndex: IndexSet ){
        //guard let index = atIndex.first else {return}
        if (userCourant > -1) {
            let user:Personne = listeUsers[userCourant]
            //let nombreMesures:Int = user.diabete.sucre.count
            user.diabete.sucre.remove(atOffsets: atIndex)
            save2File()
            
        }
    }
    */
    func removeMesureTension(atIndex: IndexSet ){
        guard let index = atIndex.first else {return}
        print("remove : \(index)")
        //(userCourant > -1) && (index > -1)
        if (userCourant > -1)  && (index > -1) {
            let user:Personne = listeUsers[userCourant]
            let nombreMesures:Int = user.tension.maTension.count
            if (nombreMesures > 0) && (index < nombreMesures){
                user.tension.maTension.remove(at: index)
                save2File()
            }
            //user.tension.maTension.remove(atOffsets: atIndex)
            //save2File()
            
        }
    }
    func removeMesureRapport(atIndex: IndexSet ){
        guard let index = atIndex.first else {return}
        print("remove : \(index)")
        //(userCourant > -1) && (index > -1)
        if (userCourant > -1)  && (index > -1) {
            let user:Personne = listeUsers[userCourant]
            let nombreMesures:Int = user.rapportsQuotidien.count
            if (nombreMesures > 0) && (index < nombreMesures){
                user.rapportsQuotidien.remove(at: index)
                save2File()
            }
            //user.tension.maTension.remove(atOffsets: atIndex)
            //save2File()
        }
        
    }
    
    
    
    // Sauvegardes sur userdefault
    
    func save() {
        let userdefault = UserDefaults.standard
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        

        if let encoded = try? encoder.encode(listeUsers){
            userdefault.set(encoded, forKey: USERS)
            userdefault.set(userCourant, forKey: CURRENT_USER)
        }
    }
    
    
    func recall() {
        let userdefault = UserDefaults.standard
        listeUsers = userdefault.object(forKey: USERS) as? [Personne] ?? [Personne]()
        userCourant = userdefault.integer(forKey: CURRENT_USER)
    }
    
    // MARK: - sauvegarde sur fichiers
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
            //trace(message: "sauvegarde : \n \(aSauver)")
        }
    }
    // lire un fichier s'il existe
    func recallFile() {
        let lesListes = readFromFile() ?? ""
        //print(lesListes)
        if lesListes != "" {
            listeUsers = jsonToidentites(sJson: lesListes) ?? [Personne]()
        } else {
            listeUsers = [Personne]()
        }
        //trace(message: "lecture : \n \(lesListes)")
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
    
    func jsonToidentites(sJson:String) -> [Personne]? {
        let jsonData = Data(sJson.utf8)
        let decoder = JSONDecoder()
        if let patient = try? decoder.decode([Personne].self, from: jsonData){
            //let patient : Patient
            return patient
        }
        return nil
    }
    
    
    func trace (message:String){
        print(" Trace : " + message + "\n --------------------------\n")
    }
    /*
    func recall() -> [Personne]? {
        let userdefault = UserDefaults.standard
        if let saved = userdefault.object(forKey: USERS) as? Data {
            let decoder = JSONDecoder()
            if let sucres = try? decoder.decode(Users.self, from: saved) {
                return sucres.listePatients
            }
        }
        return nil
    }
 */
    
    //-----------------------
    //MARK: - Tests
    
    func toTest(){
        testUsers.addNewUser(nom: "Mozart", prenom: "Amadeus")
        testUsers.addNewUser(nom: "Salieri", prenom: "Marcel")
        testUsers.addNewUser(nom: "Beethoven", prenom: "Ludwig")
    }

}

var testUsers = Users()
//testUsers.toTest()


 

/*
 nomCurrentUser: "Mozart", prenomCurrentUser: "Amadeus", listeUsers: [
     Personne(nom: "Mozart", prenom: "Amadeus"),
     Personne(nom: "Salieri", prenom: "Marcel"),
     Personne(nom: "Beethoven", prenom: "Ludwig")
     ]
 
testUsers.listeUsers = [
Personne(nom: "Mozart", prenom: "Amadeus"),
Personne(nom: "Salieri", prenom: "Marcel"),
Personne(nom: "Beethoven", prenom: "Ludwig")
]
 
 
 sortie tojson
 
 
 {\n  \"userCourant\" : 0,
 \n  \"listeUsers\" :
    [\n    {\n      \"prenom\" : \"Pat\",\n      \"glycemie\" : [\n\n      ],
        \n      \"diabete\" :
        {\n        \"sucre\" : [\n\n        ]\n      },\n      \"id\" : \"79D131DB-D874-4F0A-BBE2-572BB167CE33\",\n
            \"nom\" : \"Lano\",\n      \"rapportsQuotidien\" : [\n\n      ],\n      \"tension\" : {\n        \"maTension\" : [\n\n        ]\n      },\n      \"poids\" : 76\n    }
        \n  ]\n}")
 
*/

