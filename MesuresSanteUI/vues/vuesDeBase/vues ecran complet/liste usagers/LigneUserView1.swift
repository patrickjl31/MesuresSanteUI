//
//  LigneUserView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 28/02/2022.
//

import SwiftUI

struct LigneUserView1: View {
    
    @ObservedObject  var user: Identites
    //var patient : Personne
    //@State var isChecked: Bool = true
    
    // MARK: - Fonctions
    func setCourant(){
        user.SelectToNom(nom: user.liste[user.selected].prenom, prenom: user.liste[user.selected].prenom)
        //user.setCurrentUser(nom: patient.prenom, prenom: patient.prenom)
    }
    
    var body: some View {
        let patient = user.liste[user.selected]
        let isChecked = user.isSelected(nom: patient.nom, prenom: patient.prenom)
        let personChecked = "person.fill.checkmark"
        let person = "person"
        HStack {
            Image(systemName: isChecked ? personChecked : person)
                .font(.system(size: 28, weight: .bold, design: .rounded))
            Text("\(patient.prenom) \(patient.nom)")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            
        }
        onTapGesture {
            //setCourant()
        }
    }
}

struct LigneUserView1_Previews: PreviewProvider {
    static var previews: some View {
        LigneUserView1(user: Identites())
    }
}
