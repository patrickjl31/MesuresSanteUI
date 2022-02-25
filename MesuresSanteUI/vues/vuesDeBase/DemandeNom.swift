//
//  DemandeNom.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 14/02/2022.
//

import SwiftUI

struct DemandeNom: View {
    
    @ObservedObject var patient : Personne
    
    @State var nom: String = ""
    @State var prenom: String = ""
    
    var body: some View {
        VStack{
            Text("Qui êtes-vous ?")
                .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundColor(Color("BleuSombre"))
            Group {
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
          
            Button {
                //var personne = datas.patient
                if nom.count > 0 {
                    patient.nom = nom
                    patient.saveIdentity()
                }
                if prenom != "" {
                    patient.prenom = prenom
                    patient.saveIdentity()
                }
                
            } label: {
                BlocBouton(texte: "Valider")
            }

        }
    }
}

struct DemandeNom_Previews: PreviewProvider {
    static var previews: some View {
        DemandeNom(patient: Personne())
        //DemandeNom(datas: <#Mesures#>, nom: .constant(""))
    }
}
