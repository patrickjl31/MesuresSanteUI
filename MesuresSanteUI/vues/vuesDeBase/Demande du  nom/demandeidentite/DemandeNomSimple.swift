//
//  DemandeNomSimple.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 05/03/2022.
//

import SwiftUI

struct DemandeNomSimple: View {
    // MARK: - propriétés
    
    //@ObservedObject var patients : Identites
    @ObservedObject var users : Users
    
    @State var nom: String //= ""
    @State var prenom: String //= ""
    
    @State var showAlert:Bool = false
    
    // MARK: - foncions
    func identiteRenseignee()-> Bool{
        return (nom.count > 0) && (prenom.count > 0)
    }
    
    func dismissAlert(){
        showAlert = false
    }
    func validation() {
        //patients.addIdentite(nom: nom, prenom: prenom)
        users.addNewUser(nom: nom, prenom: prenom)
    }
    func changeIndexTo(value:Int){
        users.setIndexCurrentUser(toIndex: value)
    }
    
    // MARK: - body
    var body: some View {
        VStack {
            Text("Qui êtes-vous ?")
                .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundColor(Color("BleuSombre"))
            
            VStack {
              
                    HStack{
                        Button {
                            //patient.effaceIdentite()
                            nom = ""
                            prenom = ""
                            //action = .creer
                            //print("Valider?")
                            } label: {
                                VStack( spacing: 0){
                                Image(systemName: "highlighter")
                                Text("Nouveau")
                                    .font(.system(size: 16, weight: .light))
                                }
                                .font(.system(size: 18, weight: .light))
                        }
                        
                        VStack{
                            HStack {
                                Text("Nom : ")
                                TextField("Votre nom :", text: $nom)
                            }
                            HStack {
                                Text("Prénom : ")
                                TextField("Votre prénom :", text: $prenom)
                                }
                            }
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color("BleuSombre"))
                        .padding(.horizontal, 10)
                        }
                        
                    }//HStack
                    
                 
            
            if identiteRenseignee(){
                Button {
                    showAlert = true
                    
                    //var personne = datas.patient
                    validation()
                }
            label: {
                    //Text("Valider")
                    BlocBouton(texte: "Valider")
                /* */
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Validation ?"), message: Text("Voulez vous réellement enregistrer \(prenom), \(nom) ?"), primaryButton: .default(
                            Text("Annuler"),action: dismissAlert), secondaryButton:.destructive(Text("OK"),action: validation)
                        )
                    }
                // */
                }
            }//If
            
            //---- la liste---
            //Text("Nombre de noms : \(users.listeUsers[users.userCourant].count)")
            /* */
            if users.userCourant > -1 {
                let patient:[Personne] = users.listeUsers
                List{
                    ForEach((0..<users.listeUsers.count), id:  \.self){
                        index in
                        LigneIdentite(users: users, nom: users.listeUsers[index].nom, prenom: users.listeUsers[index].prenom)
                        /*
                            .onTapGesture {
                                changeIndexTo(value: index)
                                //users.setIndexCurrentUser(toIndex: index)
                            }
                        */
                    }
                }
             
            }
            //*/
        }
        
    }
}

struct DemandeNomSimple_Previews: PreviewProvider {
    static var previews: some View {
        DemandeNomSimple(users: Users(), nom: "getorix", prenom: "Vercin")
    }
}

