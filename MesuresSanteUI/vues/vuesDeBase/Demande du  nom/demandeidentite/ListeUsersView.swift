//
//  ListeUsersView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 09/03/2022.
//

import SwiftUI

struct ListeUsersView: View {
    
    @ObservedObject var users : Users
    
    
    var body: some View {
        //if users.userCourant > -1 {
            let patient:[Personne] = users.listeUsers
            List{
                ForEach((0..<patient.count), id:  \.self){
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
         
        //}
    }
}

struct ListeUsersView_Previews: PreviewProvider {
    static var previews: some View {
        ListeUsersView(users: Users())
    }
}
