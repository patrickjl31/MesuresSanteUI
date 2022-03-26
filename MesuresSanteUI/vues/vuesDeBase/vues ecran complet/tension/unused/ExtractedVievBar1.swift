//
//  ExtractedVievBar1.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 10/03/2022.
//

import SwiftUI

struct ExtractedVievBar1: View {
    @ObservedObject var datas : Mesures
    
    var epaisseur : CGFloat = 30
    var coefHauteur : CGFloat = 26
    
    var body: some View {
        ScrollView(.horizontal) {
            //Spacer(50)
            
            HStack(alignment: .bottom, spacing: 2, content: {
                ForEach(datas.maTension, id:\.self){mesure in
                    //Text("Systolique = \(mesure.systolique)")
                    ZStack(alignment: .bottom, content: {
                        
                        // Les barres
                        
                        VStack {
                            HStack(alignment: .bottom) {
                                Rectangle()
                                    .fill(COUL_SYSTO)
                                    .opacity((mesure.moment == "PM") ? 0.4 : 1)
                                    .frame(width: epaisseur, height: CGFloat(mesure.systolique) * coefHauteur)
                                 
                                Spacer(minLength: 0)
                                
                                Rectangle()
                                    .fill(COUL_DIASTO)
                                    .opacity((mesure.moment == "PM") ? 0.4 : 1)
                                    .frame(width: epaisseur, height: CGFloat(mesure.distolique) * coefHauteur)
                                
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
                            //.offset(x: 0.0, y: 10)
                                .padding(.vertical, 8)
                        }
                        
                        // Le texte
                        HStack {
                            //Spacer()
                            Text("Syst : \(mesure.systolique, specifier: "%.1f"), Dist: \(mesure.distolique, specifier: "%.1f")")
                                .font(.headline)
                                .background(Color.yellow)
                                .rotationEffect(.degrees(-90))
                                .fixedSize()
                                .frame(width: 40, height: 200, alignment: .center)
                                .offset(y: -50)
                            
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

struct ExtractedVievBar1_Previews: PreviewProvider {
    static var previews: some View {
        ExtractedVievBar1(datas: testMesures)
    }
}
