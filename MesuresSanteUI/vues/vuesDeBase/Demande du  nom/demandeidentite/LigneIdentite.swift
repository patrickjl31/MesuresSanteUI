//
//  LigneIdentite.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 05/03/2022.
//

import SwiftUI

struct LigneIdentite: View {
    
    //@ObservedObject var patients : Identites
    @ObservedObject var users : Users
    var nom: String //= ""
    var prenom: String //= ""
    
    var body: some View {
        HStack {
            Text("\(prenom) \(nom)")
            Spacer()
            //let i:Bool = users.isCurrentUser(nom: nom, prenom: prenom)
            if users.isCurrentUser(nom: nom, prenom: prenom
            ) {
                Image(systemName: "checkmark")
            }
                
        }
        
    }
}

struct LigneIdentite_Previews: PreviewProvider {
    static var previews: some View {
        LigneIdentite(users: Users(), nom: "rzez", prenom: "ghfyj")
    }
}
