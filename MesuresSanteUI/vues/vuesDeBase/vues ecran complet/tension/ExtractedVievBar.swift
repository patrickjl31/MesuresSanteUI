//
//  ExtractedVievBar.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 19/02/2022.
//

import SwiftUI

struct ExtractedVievBar: View {
    @ObservedObject var datas : Mesures
    
    var epaisseur : CGFloat = 30
    var coefHauteur : CGFloat = 26
    
    // MARK: - fonctions
    func tensionMaxiMin()->(maxi: Double, mini : Double){
        var max: Double = 0
        var min:Double = 1000
        for index in 0..<datas.maTension.count{
            if max < datas.maTension[index].systolique {
                max = datas.maTension[index].systolique
            }
            if min > datas.maTension[index].systolique {
                min = datas.maTension[index].systolique
            }
            if max < datas.maTension[index].distolique {
                max = datas.maTension[index].distolique
            }
            if min > datas.maTension[index].distolique {
                min = datas.maTension[index].distolique
            }
        }
        return (max, min)
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            let maxEtMin = tensionMaxiMin()
            let max = maxEtMin.maxi
            let min = maxEtMin.mini
            //Text("max = \(max), min = \(min)")
            let ecart = max - min
            //let hauteurVue = screenHeight
            let hanteurUtile = screenHeight / 3
            
            //Spacer(50)
            
            HStack(alignment: .bottom, spacing: 2, content: {
                ForEach(datas.maTension, id:\.self){mesure in
                    //Text("Systolique = \(mesure.systolique)")
                    ZStack(alignment: .bottom, content: {
                        
                        // Les barres
                        
                        VStack {
                            HStack(alignment: .bottom) {
                                let systol = hanteurUtile / ecart * (mesure.systolique - min + 1)
                                let diastol = hanteurUtile / ecart * (mesure.distolique - min + 1)
                                Rectangle()
                                    .fill(COUL_SYSTO)
                                    .opacity((mesure.moment == "PM") ? 0.4 : 1)
                                    .frame(width: epaisseur, height: CGFloat(systol))
                                //CGFloat(mesure.systolique) * coefHauteur)
                                 
                                Spacer(minLength: 0)
                                
                                Rectangle()
                                    .fill(COUL_DIASTO)
                                    .opacity((mesure.moment == "PM") ? 0.4 : 1)
                                    .frame(width: epaisseur, height: CGFloat(diastol))
                                //mesure.distolique) * coefHauteur)
                                
                                //Spacer(minLength: 3)
                                
                            }
                            // la date
                            let quand = mesure.dateMesure.identDateAndMoment()
                            Text("\(quand.date) / \(quand.moment)")
                                //.font(.footnote)
                                .font(Font.system(size: 10))
                                .fontWeight(.medium)
                                .rotationEffect(.degrees(-45))
                                .frame(width: epaisseur * 2, height: 50
                                       , alignment: .leading)
                            //.offset(x: 0.0, y: -10)
                                .padding(.vertical, 8)
                        }
                        
                        // Le texte
                        HStack {
                            //Spacer()
                            Text("Syst : \(mesure.systolique, specifier: "%.1f"), Diast: \(mesure.distolique, specifier: "%.1f")")
                                .font(.caption2)
                                .background(Color.yellow)
                                .rotationEffect(.degrees(-90))
                                .fixedSize()
                                .frame(width: 40, height: 180, alignment: .center)
                                .offset(y: -70)
                            
                            Spacer()
                            
                        }//HStack
                        
                        
                        //Spacer()
                        /*
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
                        */
                        
                        
                    })
                    
                }
                //Spacer(minLength: 5)
            })
            
            
        }
    }
}

struct ExtractedVievBar_Previews: PreviewProvider {
    static var previews: some View {
        ExtractedVievBar(datas: testMesures)
    }
}
