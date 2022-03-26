//
//  LargeGraphicSucre.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 20/02/2022.
//

import SwiftUI

struct LargeGraphicSucre: View {
    
    // MARK: - Propriétés
    @ObservedObject var patient : Personne
    //@ObservedObject var datas : MesuresSucre
    
    
    var hauteur:CGFloat = 800
    //var systoliques : [Mesure] = []
            
    //@State var typeMesureSelected : Int = 0
    //var typeMesures = ["Systolique", "Diastolique", "Les deux"]
    
    // MARK: - Fonctions
    /*

    func verification(){
        let res = courbes()
    }
    */
    
    
    
    var body: some View {
        
        
        //ZStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: true) {
                    let largeur:CGFloat = CGFloat(patient.diabete.sucre.count * 40)
                    
                    VStack{
                        if !patient.diabete.noMesures() {
                            let courbe = patient.diabete.courbes()
                            //let test: Double = courbe.valSucre[0]
                            
                            
                            ZStack(alignment: .leading) {
                                // To test
                                /*
                                VStack {
                                    Text("nombre mesures : \(courbe.valSucre.count),  sucre (0) : \(courbe.valSucre[0]), maxi :  \(courbe.maxi), mini :  \(courbe.mini)  ")
                                            .multilineTextAlignment(.center)
                                        .lineLimit(3)
                                    Spacer()
                                }
                                */
                                
                                CarroyageHorizontal(limB: courbe.mini, limH: courbe.maxi, basDeCourbe: 100, hauteurCourbe: 400)
                                                                    //.frame(width: 800, height: 200)
                                
                                TraceCourbe1(symbole: SYMBOLE_COUVERT ,listeDates: courbe.dates,listePointsX: courbe.valSucre,yMax: courbe.maxi, yMin: courbe.mini,  couleur: COUL_SYSTO, basDeCourbe: 100)
                                    .padding(.horizontal, 20)
                                    //.frame(width: 800, height: 200)
                                
                                    
                            
                                
                                //AbcissesView(bas: Int(courbes.mini.rounded(.down)), haut: Int(courbes.maxi.rounded(.up)), ecart: 50)
                            }
                            .frame(width: largeur, height: hauteur)
                            
                            
                            
                        } // VStack
                    }
                    
                    
                }//scrollview
                //AbcissesView(bas: 5, haut: 20, ecart: 50)
               
                LegendeSucre()
                
            } // VStack
            //AbcissesView(bas: 5, haut: 20, ecart: 40)
            
            
            
        //} // ZStack
        
        //.frame(width: 400, height: 400)
    }
}

struct LargeGraphicSucre_Previews: PreviewProvider {
    static var previews: some View {
        //let malade = Personne()
        //Personne.glycemie = testSucre
        LargeGraphicSucre(patient: Personne())
    }
}
