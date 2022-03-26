//
//  AccueilPatients.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 26/02/2022.
//

import SwiftUI

struct AccueilPatients: View {
    
    // MARK: - Propriétéss
    //@ObservedObject var users: Personne
    @ObservedObject var users: Users
    //@ObservedObject var patient : Personne
    
    //@State private var currenUser = -1
    
    //MARK:- Fonctions
    func removeUser(at offsets: IndexSet){
        users.removeUserAtIndex(index: offsets)
    }
    
    func modifyCheck(index:Int){
        users.setIndexCurrentUser(toIndex: index)
    }
    
    var body: some View {
           
        VStack {
            HStack {
                Image("logo-sante-2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                VStack {
                    DateDuJourView(date: date)
                    Text("Votre santé au jour le jour...")
                        .modifier(ItaliqueBleuModifier())
                        
                        
                }
            }
            //DateDuJourView(date: date)
                .padding(20)
            //Spacer()
            // est-ce qu'ilexiste des utilisateurs ?
            // Si non, je demande à créer le premier et j'en fais l'utilisateur courant (demande creation)
            // si oui,
            // s'il existe un utilisateur courant, demande(modif), affichage liste
            // sinon je choisis le premier user comme courant,
            //demande(modif), affichage liste
            let courant:Int = users.userCourant
            
            if courant > -1 {
                //let patient : Personne = users.listeUsers[courant]
                //let nom = users.listeUsers[courant].nom
                //let prenom = users.listeUsers[courant].prenom
                //let nom = users.nomCurrentUser
                //let prenom = users.prenomCurrentUser
                DemandeNomModifiable(users: users, action: .Modifier, nom: users.nomCurrentUser, prenom: users.prenomCurrentUser)
                
            } else {
                
                DemandeNomModifiable(users: users, action: .creer, nom: "", prenom: "")
            }
            
            /**/
            // MARK: - La liste des users
            //Text("nombre d'inscrits : \(users.listeUsers.count), index courant = \(users.userCourant)")
            if users.listeUsers.count > 0 {
                List{
                    ForEach((0..<users.listeUsers.count), id:\.self){
                        index in
                        // ligne de user
                        LigneUserView(user: users, patient: users.listeUsers[index])
                            .onTapGesture {
                                //modifyCheck(index: index)
                                users.setIndexCurrentUser(toIndex: index)
                            }
                        //, isChecked: users.isCurrentUser(nom: usager.nom, prenom: usager.prenom)
                    }
                    .onDelete(perform: removeUser(at:))
                    
                    /*
                    ForEach(users.listeUsers, id:\.self){
                        usager in
                        // ligne de user
                        LigneUserView(user: users, patient: usager)
                        //, isChecked: users.isCurrentUser(nom: usager.nom, prenom: usager.prenom)
                    }
                    .onDelete(perform: removeUser(at:))
                     */
                }
            }
             
            
           
            
           //Spacer()
        }
    }
}

struct AccueilPatients_Previews: PreviewProvider {
    static var previews: some View {
        //AccueilPatients(users: Users(), patient: Personne(nom: "Getorix",nom: "Vercin"))
        //AccueilPatients(users: Users(), patient:Personne(nom:"getorix", prenom: "Versin"))
        AccueilPatients(users: Users())
    }
}
