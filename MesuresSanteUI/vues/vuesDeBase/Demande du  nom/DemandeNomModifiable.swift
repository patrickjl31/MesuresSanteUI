//
//  QemandeNomModifiable.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 04/03/2022.
//

import SwiftUI

struct DemandeNomModifiable: View {
    @ObservedObject var users : Users
    @State var action : actionPossible
    @State var nom: String //= ""
    @State var prenom: String //= ""
   
    
    
    var body: some View {
        DemandeNom(users: users, action: action, nom: nom, prenom: prenom, nomOrigine: nom, prenomOrigine: prenom)
    }
}

struct DemandeNomModifiable_Previews: PreviewProvider {
    static var previews: some View {
        DemandeNomModifiable(users: Users(), action: .creer, nom: "marcel", prenom: "leon")
    }
}

enum actionPossible {
    case creer,
    Modifier, Muet
}
