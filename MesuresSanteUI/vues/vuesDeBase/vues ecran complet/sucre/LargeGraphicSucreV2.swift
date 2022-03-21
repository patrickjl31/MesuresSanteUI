//
//  LargeGraphicSucre1.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 20/03/2022.
//

import SwiftUI

struct LargeGraphicSucreV2: View {
    // MARK: - Propriétés
    @ObservedObject var patient : Personne
    var basDeCourbe : CGFloat
    var hauteur:CGFloat = 800
    
    //@State
    var choixtoutesMesures:Bool = true
    //@State
    var choixPrePrandial:Bool = true
    
    let choix : [String] = ["Réveil", "Apres petit déjeuner", "Avant déjeuner", "Après déjeuner", "Avant diner", "Couché"]
    let choixPre : [String] = ["Réveil", "Apres petit déjeuner", "Avanr déjeuner", "Après déjeuner", "Avant diner", "Couché"]
    let choixPost : [String] = ["Réveil", "Apres petit déjeuner", "Avanr déjeuner", "Après déjeuner", "Avant diner", "Couché"]
    //var systoliques : [Mesure] = []
            
    //@State var typeMesureSelected : Int = 0
    //var typeMesures = ["Systolique", "Diastolique", "Les deux"]
    
    // MARK: - Fonctions
    
    
    var body: some View {
        
        let sucres :[MesureSucre] = patient.diabete.sucre//datas.sucre
        
        //ZStack {
            VStack {
                /*
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
                */
                ScrollView(.horizontal, showsIndicators: true) {
                    let largeur:CGFloat = CGFloat(patient.diabete.sucre.count * 30)
                    
                    VStack{
                        
                        
                        if !patient.diabete.noMesures() {
                            
                            //let courbe = patient.diabete.courbeFine(moment: [])
                            //let test: Double = courbe.valSucre[0]
                            
                            
                            ZStack(alignment: .leading) {
                                // To test
                                
                                //CarroyageHorizontal(limB: courbe.mini, limH: courbe.maxi, basDeCourbe: 100, hauteurCourbe: 400)
                                //.frame(width: 800, height: 200)
                                if choixtoutesMesures {
                                    let courbe = patient.diabete.courbeFine(moment: ListeMomentsSucre)
                                    CarroyageHorizontal(limB: courbe.mini, limH: courbe.maxi, basDeCourbe: basDeCourbe, hauteurCourbe: 400)
                                    TraceCourbe1(symbole: SYMBOLE_COUVERT ,listeDates: courbe.dates,listePointsX: courbe.valSucre,yMax: courbe.maxi, yMin: courbe.mini,  couleur: COUL_SYSTO, basDeCourbe: basDeCourbe)
                                        .padding(.horizontal, 20)
                                } else {
                                    if choixPrePrandial {
                                        let courbe = patient.diabete.courbeFine(moment: ListeMomentsPreSucre)
                                        CarroyageHorizontal(limB: courbe.mini, limH: courbe.maxi, basDeCourbe: basDeCourbe, hauteurCourbe: 400)
                                        TraceCourbe1(symbole: SYMBOLE_COUVERT ,listeDates: courbe.dates,listePointsX: courbe.valSucre,yMax: courbe.maxi, yMin: courbe.mini,  couleur: COUL_SYSTO, basDeCourbe: basDeCourbe)
                                            .padding(.horizontal, 20)
                                    } else{
                                        let courbe = patient.diabete.courbeFine(moment: ListeMomentsPostSucre)
                                        CarroyageHorizontal(limB: courbe.mini, limH: courbe.maxi, basDeCourbe: basDeCourbe, hauteurCourbe: 400)
                                        TraceCourbe1(symbole: SYMBOLE_COUVERT ,listeDates: courbe.dates,listePointsX: courbe.valSucre,yMax: courbe.maxi, yMin: courbe.mini,  couleur: COUL_SYSTO, basDeCourbe: basDeCourbe)
                                            .padding(.horizontal, 20)
                                    }
                                }
                                //TraceCourbe1(symbole: SYMBOLE_COUVERT ,listeDates: courbe.dates,listePointsX: courbe.valSucre,yMax: courbe.maxi, yMin: courbe.mini,  couleur: COUL_SYSTO, basDeCourbe: 100)
                                    //.padding(.horizontal, 20)
                                    //.frame(width: 800, height: 200)
                                
                                    
                            
                                
                                //AbcissesView(bas: Int(courbes.mini.rounded(.down)), haut: Int(courbes.maxi.rounded(.up)), ecart: 50)
                            }
                            //.frame(idealWidth: largeur, maxWidth: .infinity, idealHeight: hauteur)
                            .frame(width: largeur, height: hauteur)
                            
                            
                            
                        } // VStack
                    }
                    
                    
                }//scrollview
                .frame(maxWidth: .infinity)
                //AbcissesView(bas: 5, haut: 20, ecart: 50)
               
                LegendeSucre()
                
            } // VStack
            //AbcissesView(bas: 5, haut: 20, ecart: 40)
            
            
            
        //} // ZStack
        
        //.frame(width: 400, height: 400)
    }
}

struct LargeGraphicSucreV2_Previews: PreviewProvider {
    static var previews: some View {
        LargeGraphicSucreV2(patient: Personne(), basDeCourbe: 250)
    }
}
