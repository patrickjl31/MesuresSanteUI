//
//  CarroyageHorizontal1.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 12/02/2022.
//

import SwiftUI

struct CarroyageHorizontal1: View {
    
    @ObservedObject var patient : Personne
    
    // les numeros des lignes de bas en haut
    var limB: Int  //= 10
    var limH:Int  //= 20
    var multi:Int = 3
    // la taille du graphique
    //var hauteurGraphique: CGFloat = 50
    //var hauteurBase: CGFloat = 100
    //var multi : Double = 1.0
    //var hauteurNiveau: CGFloat = 5
    /*
    init() {
        //hauteurNiveau = hauteurGraphique / CGFloat(limH - limB)
    }
    */
    var body: some View {
        //let hauteurNiveau = hauteurGraphique / CGFloat(limH - limB)
        let nombreLignes = limH - limB
        
        let ecart:CGFloat = CGFloat(multi)
        ZStack {
            GeometryReader{geometry in
                //let ecart = (geometry.size.height / CGFloat(limH - limB)) * CGFloat(multi)
                
                let longueur = geometry.size.width - 25
                //
                let hauteur = Int(geometry.size.height) / nombreLignes
                
                //let debut = CGFloat(limB) * ecart
                let debut = geometry.size.height - (CGFloat(limB) * ecart)
                // tracer les lignes
                ForEach((limB...limH).reversed(), id: \.self) { index in
                    let y =   debut - CGFloat(limH - index) * ecart
                    //let y = Int(hauteur * index)
                    Path{ path in
                        path.move(to: CGPoint(x: 20, y: y))
                        //path.addLine(to: CGPoint(x: longueur, y: CGFloat( y)))
                        path.addLine(to: CGPoint(x: longueur, y: CGFloat( y)))
                    }
                        .stroke(Color.black)
                    
                    //HStack {
                    /*
                        Text("\(index - limB)")
                            .font(.headline)
                        //.offset(x: 1.0, y: y - 32)
                            .position(x:10, y: y)
                        
                     */
                }
                //*
                // Tracer les étiquettes
                ForEach((limB...limH), id: \.self) { index in
                    let y =   debut + CGFloat(limB - index ) * ecart
                    Text("\(index)")
                        .font(.headline)
                    //.offset(x: 1.0, y: y - 32)
                        .position(x:10, y: y)
                }
                //*/
                
            } //geometry
            
            /*
            // Tracer les étiquettes
            ForEach((limB...limH), id: \.self) { index in
                let debut = heigthScreen - (CGFloat(limB) * ecart)
                let y =   debut + CGFloat(limB - index ) * ecart
                Text("\(index)")
                    .font(.headline)
                //.offset(x: 1.0, y: y - 32)
                           .position(x:10, y: y)
            }
            */
            
        }//ZStack
        
    }
    
}

struct CarroyageHorizontal1_Previews: PreviewProvider {
    static var previews: some View {
        CarroyageHorizontal1(patient: Personne(), limB: 5, limH: 20)
            //.previewLayout(.sizeThatFits)
    }
}
