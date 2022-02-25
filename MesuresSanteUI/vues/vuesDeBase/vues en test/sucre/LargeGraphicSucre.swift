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
    @ObservedObject var datas : MesuresSucre
    
    //var sucre: [Glycemie] = []
    
    var hauteur:CGFloat = 800
    //var systoliques : [Mesure] = []
            
    //@State var typeMesureSelected : Int = 0
    //var typeMesures = ["Systolique", "Diastolique", "Les deux"]
    
    // MARK: - Fonctions
    /*
    func courbes() -> (sucre:[Double], maxi : Double, mini:Double) {
        let listeSucre = patient.glycemie
        if listeSucre.count < 2 {
            return ([],0,0)
        }
        var mesuresSucre : [Double] = []
        
        
        for elem in 0..<listeSucre.count {
            mesuresSucre.append(listeSucre[elem].sucre)
            
        }
        //let maxi = max(diastolique.max()!,systolique.max()!)
        //let mini = min(diastolique.min()!, systolique.min()!)
        if let maxi = mesuresSucre.max(), let mini = mesuresSucre.min() {
            return (mesuresSucre, maxi, mini)
        } else {
            return (mesuresSucre, 100, 0)
        }
    }
    
    func verification(){
        let res = courbes()
    }
    */
    
    
    
    var body: some View {
        //let datas = patient.diabete
        
        
        ZStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: true) {
                    let largeur:CGFloat = CGFloat(datas.sucre.count * 40)
                    
                    VStack{
                        if !datas.noMesures() {
                            let courbe = datas.courbes()
                            //Text("\(courbe.sucre[0])")
                            ZStack(alignment: .leading) {
                                
                                CarroyageHorizontal(limB: courbe.mini, limH: courbe.maxi, basDeCourbe: 0, hauteurCourbe: 499)
                                                                    //.frame(width: 800, height: 200)
                                
                                TraceCourbe(listeDates: courbe.dates,listePointsX: courbe.valSucre, couleur: COUL_SYSTO, multi: 150)
                                    .padding(.horizontal, 20)
                                    //.frame(width: 800, height: 200)
                                
                                    
                            
                                
                                //AbcissesView(bas: Int(courbes.mini.rounded(.down)), haut: Int(courbes.maxi.rounded(.up)), ecart: 50)
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
                            Text("Sucre ")
                                .foregroundColor(COUL_SYSTO)
                            
                            //Text("Diastolique")
                                //.foregroundColor(COUL_DIASTO)
                            //Spacer()
                        }
                        .font(.title3)
            } // VStack
            //AbcissesView(bas: 5, haut: 20, ecart: 40)
            
            
            
        }
        
        
        //.frame(width: 400, height: 400)
    }
}

struct LargeGraphicSucre_Previews: PreviewProvider {
    static var previews: some View {
        //let malade = Personne()
        //Personne.glycemie = testSucre
        LargeGraphicSucre(patient: Personne(), datas: MesuresSucre())
    }
}
