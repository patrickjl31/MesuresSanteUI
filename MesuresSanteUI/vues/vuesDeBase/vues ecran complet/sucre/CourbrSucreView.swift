//
//  CourbrSucreView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 24/02/2022.
//

import SwiftUI

struct CourbeSucreView: View {
    
    @ObservedObject var patient : Personne
    
    @State var choixtoutesMesures:Bool = true
    @State var choixPrePrandial:Bool = true
    //@ObservedObject var datas : Mesures
    
    
    var body: some View {
        ZStack {
            
            VStack{
                TitulatureView(titreSpecifique: "Votre glycémie en courbes...")
                    .padding(.top, 250)
                PeriodeView(patient: patient)
                    //.offset(x: 0, y: 30)
                Toggle("Voir les mesures post et preprandiale ensembles ?", isOn: $choixtoutesMesures)
                    .tint(.blue)
                    .modifier(PetitBleuModifier())
                    .padding(.horizontal,10)
                if !choixtoutesMesures {
                    //let pre = "Voir la courbe de la glycémie pre prandiale ?"
                    let pre = "Glycémie pre prandiale ?"
                    //let post = "Voir la courbe de la glycémie post prandiale ?"
                    let post = "Glycémie post prandiale ?"
                    Toggle(choixPrePrandial ? pre : post, isOn: $choixPrePrandial)
                        .tint(.blue)
                        .modifier(PetitBleuModifier())
                        .padding(.horizontal,10)
                        //.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    //choixPrePrandial ? setChoix(quoi: ["Réveil", "Avanr déjeuner", "Avant diner"]) : setChoix(quoi: ["Apres petit déjeuner",  "Après déjeuner", "Couché"])
                }
                // Tracé des courbes
                //Spacer()
                
                //let courbe = patient.diabete.courbeFine(moment: ListeMomentsSucre)
                //HStack {
                    //Spacer()
                //    CarroyageHorizontal(limB: courbe.mini, limH: courbe.maxi, basDeCourbe: 300, hauteurCourbe: 400)
                //}
                
                LargeGraphicSucreV2(patient: patient, basDeCourbe: 350, choixtoutesMesures: choixtoutesMesures, choixPrePrandial: choixPrePrandial )
                //Spacer()
            }
            
            //LargeGraphicSucreV2(patient: patient, choixtoutesMesures: choixtoutesMesures, choixPrePrandial: choixPrePrandial )
        }
    }
}

struct CourbeSucreView_Previews: PreviewProvider {
    static var previews: some View {
        //CourbrSucreView(patient: Personne(), datas: Mesures())
        CourbeSucreView(patient: Personne(),choixtoutesMesures: true, choixPrePrandial: true)
    }
}
