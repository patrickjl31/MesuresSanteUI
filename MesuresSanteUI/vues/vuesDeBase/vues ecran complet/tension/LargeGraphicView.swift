//
//  LargeGraphicView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 12/02/2022.
//

import SwiftUI

struct LargeGraphicView: View {
    
    @ObservedObject var patient:Personne
    //@ObservedObject var datas : Mesures
    var hauteur:CGFloat = 800
    //var systoliques : [Mesure] = []
            
    //@State var typeMesureSelected : Int = 0
    //var typeMesures = ["Systolique", "Diastolique", "Les deux"]
    
    // MARK: - Fonctions
    func maxMin()->(max:Double, min:Double){
        //
        return (100,0)
    }
    
    
    var body: some View {
        
        ZStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: true) {
                    let largeur:CGFloat = CGFloat(patient.tension.maTension.count * 40)
                    VStack{
                        if !patient.tension.noMesures() {
                            let courbes = patient.tension.courbes()//datas.courbes()
                            //let listeDates = 
                            ZStack(alignment: .leading) {
                                
                                CarroyageHorizontal(limB: courbes.mini, limH: courbes.maxi, basDeCourbe: 100, hauteurCourbe: 400)
                                
                                TraceCourbe(listeDates: courbes.dates,listePointsX: courbes.systol, couleur: COUL_SYSTO, multi: 30)
                                    .padding(.horizontal, 20)
                                    //.frame(width: 800, height: 200)
                                TraceCourbe(listeDates: courbes.dates,listePointsX: courbes.diastol, couleur: COUL_DIASTO, multi: 30)
                                    .padding(.horizontal, 20)
                                    //.frame(width: 800, height: 200)
                                //CarroyageHorizontal1(patient: patient, limB: Int(courbes.mini.rounded(.down)), limH: Int(courbes.maxi.rounded(.up)), multi: Int(30))
                                
                                
                            }
                            .frame(width: largeur, height: hauteur)
                            
                            /*
                            let ecart:CGFloat = CGFloat(3)
                            ForEach((Int(courbes.mini.rounded(.down))...Int(courbes.maxi.rounded(.up))), id: \.self) { index in
                                let debut = heigthScreen - (CGFloat(Int(courbes.mini.rounded(.down))) * ecart)
                                let y =   debut + CGFloat(Int(courbes.maxi.rounded(.up)) - index ) * ecart
                                Text("\(index)")
                                    .font(.headline)
                                //.offset(x: 1.0, y: y - 32)
                                           .position(x:10, y: y)
                            }
                            */
                            
                            
                        }
                    }
                }//scrollview
                //AbcissesView(bas: 5, haut: 20, ecart: 50)
                
                //PeriodeView(patient: , datas: datas)
                
                HStack(alignment: .center, spacing: 10) {
                            Text("Légende : ")
                                .foregroundColor(.black)
                            //Spacer()
                            Text("Systolique ")
                                .foregroundColor(COUL_SYSTO)
                            
                            Text("Diastolique")
                                .foregroundColor(COUL_DIASTO)
                            //Spacer()
                        }
                        .font(.title3)
                        .offset(y: -50)
            } // VStack
            //AbcissesView(bas: 5, haut: 20, ecart: 40)
            
            
            
        }
        
        
        //.frame(width: 400, height: 400)
    }
}

struct LargeGraphicView_Previews: PreviewProvider {
    static var previews: some View {
        LargeGraphicView(patient: Personne())
    }
}
