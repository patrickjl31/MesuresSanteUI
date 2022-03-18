//
//  LargeGraphicView1.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 07/03/2022.
//

import SwiftUI

struct LargeGraphicView1: View {
    
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
    func trace(quoi: String){
        print(quoi)
    }
    
    
    var body: some View {
        
        ZStack {
            let datas:Mesures = patient.tension
            VStack {
                ScrollView(.horizontal, showsIndicators: true) {
                    let largeur:CGFloat = CGFloat(datas.maTension.count * 40)
                    VStack{
                        if !datas.noMesures() {
                            let courbes = patient.tension.courbes() 
                            //let listeDates =
                            ZStack(alignment: .leading) {
                                
                                CarroyageHorizontal(limB: courbes.mini, limH: courbes.maxi, basDeCourbe: 100,  hauteurCourbe: 400)
                                //trace(quoi: "mini : \(courbes.mini), maxi : \(courbes.maxi)")
                                TraceCourbe1(symbole: SYMBOLE_COEUR ,listeDates: courbes.dates,listePointsX: courbes.systol,yMax: courbes.maxi, yMin: courbes.mini, couleur: COUL_SYSTO, basDeCourbe: 100)
                                    .padding(.horizontal, 20)
                                    //.frame(width: 800, height: 200)
                                TraceCourbe1(symbole: SYMBOLE_COEUR ,listeDates: courbes.dates,listePointsX: courbes.diastol ,yMax: courbes.maxi, yMin: courbes.mini, couleur: COUL_DIASTO, basDeCourbe: 100)
                                    .padding(.horizontal, 20)
                                    //.frame(width: 800, height: 200)
                                /*
                                TraceCourbe(listeDates: courbes.dates,listePointsX: courbes.systol, couleur: COUL_SYSTO, multi: 30)
                                    .padding(.horizontal, 20)
                                    //.frame(width: 800, height: 200)
                                TraceCourbe(listeDates: courbes.dates,listePointsX: courbes.diastol, couleur: COUL_DIASTO, multi: 30)
                                    .padding(.horizontal, 20)
                                    //.frame(width: 800, height: 200)
                                 */
                                //CarroyageHorizontal1(patient: patient, limB: Int(courbes.mini.rounded(.down)), limH: Int(courbes.maxi.rounded(.up)), multi: Int(30))
                                
                                
                            }
                            .frame(width: largeur, height: hauteur)
                            
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

struct LargeGraphicView1_Previews: PreviewProvider {
    static var previews: some View {
        LargeGraphicView1(patient: Personne())
    }
}



/*
 
 systol    [Double]    4 values
 [0]    Double    15.9
 [1]    Double    14.4
 [2]    Double    11
 [3]    Double    14.700000000000001
 diastol    [Double]    4 values
 [0]    Double    10.800000000000001
 [1]    Double    10.5
 [2]    Double    7.5
 [3]    Double    9.8000000000000007
 fCoeur    [Double]    4 values
 [0]    Double    83
 [1]    Double    98
 [2]    Double    73
 [3]    Double    92
 dates    [Foundation.Date]    4 values
 [0]    Foundation.Date    2022-03-09 17:49:32 UTC
 [1]    Foundation.Date    2022-03-10 11:09:01 UTC
 [2]    Foundation.Date    2022-03-10 11:09:01 UTC
 [3]    Foundation.Date    2022-03-10 11:09:01 UTC
 maxi    Double    15.9
 mini    Double    7.5
 
 
 [[15.9, 14.4,11,14.7][10.800000000000001,10.5,7.5,9.8000000000000007]]

 
 */
