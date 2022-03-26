//
//  LigneUserView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 06/03/2022.
//

import SwiftUI

struct LigneUserView: View {
    
    @ObservedObject  var user: Users
    var patient : Personne
    
    
    var body: some View {
        HStack {
            let isChecked = user.isCurrentUser(nom: patient.nom, prenom: patient.prenom)
            
                //.font(.system(size: 28, weight: .bold, design: .rounded))
            Text("\(patient.prenom) \(patient.nom)")
                .modifier(PetitBleuModifier())
                //.font(.title3)
                //.fontWeight(.bold)
                .multilineTextAlignment(.leading)
            Spacer()
            if isChecked {Image(systemName: "checkmark")}
             
        }
            
    }
             
}

struct LigneUserView_Previews: PreviewProvider {
    static var previews: some View {
        LigneUserView(user: Users(),patient: Personne(nom: "duclou", prenom: "leon"))
    }
}
