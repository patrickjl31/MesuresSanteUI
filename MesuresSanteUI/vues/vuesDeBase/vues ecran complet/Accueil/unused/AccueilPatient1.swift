//
//  AccueilPatient1.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 05/03/2022.
//

import SwiftUI

struct AccueilPatient1: View {
    // MARK: - Propriétéss
    @ObservedObject var users: Identites
    //@ObservedObject var users: Users
    //@ObservedObject var patient : Personne
    
    //@State private var currenUser = -1
    
    //MARK:- Fonctions
    func removeUser(at offsets: IndexSet){
        //users.removeUserAtIndex(index: offsets)
    }
    
    var body: some View {
           
        VStack {
            /*
            DateDuJourView(date: date)
                .padding(20)
            //Spacer()
            // est-ce qu'ilexiste des utilisateurs ?
            // Si non, je demande à créer le premier et j'en fais l'utilisateur courant (demande creation)
            // si oui,
            // s'il existe un utilisateur courant, demande(modif), affichage liste
            // sinon je choisis le premier user comme courant,
            //demande(modif), affichage liste
            let courant:Int = users.selected
            if courant > -1 {
                //let nom = users.listeUsers[courant].nom
                //let prenom = users.listeUsers[users.selected].prenom
                let nom = users.liste[users.selected].nom
                let prenom = users.liste[users.selected].prenom
                DemandeNomSimple(patients: users, nom: nom, prenom: prenom)
            } else {
                //DemandeNom(users: users, action: .creer, nom: "", prenom: "")
                DemandeNomSimple(patients: users, nom: "", prenom: "")
            }
            
            /**/
            // MARK: - La liste des users
            Text("nombre d'inscrits : \(users.listeUsers.count), index courant = \(users.userCourant)")
            let courant:Int = users.selected
            if courant > -1 {
                List{
                    ForEach((0..<users.liste[courant].count), id:\.self){
                        index in
                        // ligne de user
                        LigneUserView1(user: users)
                        //LigneUserView(user: users.liste[courant].personne)
                        //, isChecked: users.isCurrentUser(nom: usager.nom, prenom: usager.prenom)
                    }
                    .onDelete(perform: removeUser(at:))
                }
            }
             
            
           
            
           //Spacer()
             
             */
        }
    }
             
}

struct AccueilPatient1_Previews: PreviewProvider {
    static var previews: some View {
        AccueilPatient1(users: Identites())
    }
}
