//
//  LargeGraphicSucre1.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 28/02/2022.
//

import SwiftUI

struct LargeGraphicSucre1: View {
    
    @ObservedObject var patient:Personne
    @ObservedObject var datas : MesuresSucre
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
        VStack{
            ScrollView(.horizontal, showsIndicators: true){
                //let largeur:CGFloat = CGFloat(datas.sucre.count * 40)
                if !datas.noMesures() {
                    let courbe = datas.courbes()
                    ZStack {
                        CarroyageHorizontal(limB: courbe.mini, limH: courbe.maxi, basDeCourbe: 100, hauteurCourbe: 400)
                        TraceCourbe(listeDates: courbe.dates, listePointsX: courbe.valSucre, couleur: COUL_SYSTO, multi: 30)
                    }
                }
            }
            
            //LegendeSucre()
        }
        
    }
}

struct LargeGraphicSucre1_Previews: PreviewProvider {
    static var previews: some View {
        LargeGraphicSucre1(patient: Personne(), datas: MesuresSucre())
    }
}
