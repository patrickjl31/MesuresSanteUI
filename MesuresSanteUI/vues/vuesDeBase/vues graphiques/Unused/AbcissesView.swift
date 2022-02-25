//
//  AbcissesView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 12/02/2022.
//

import SwiftUI

struct AbcissesView: View {
    
    
    var bas = 4
    var haut = 20
    var ecart = 50
    
    
    var body: some View {
        
        let nbElems = haut - bas
         //CGFloat(5)
        
        
        HStack {
            
           //Spacer()
            GeometryReader {geo in
                let hauteur = geo.size.height
                let ecart1:CGFloat = CGFloat( hauteur / CGFloat(nbElems))
                
                VStack(alignment: .trailing) {
                    ForEach((bas...haut).reversed(), id: \.self) { index in
                        //let debut = heigthScreen - (CGFloat(Int(courbes.mini.rounded(.down))) * ecart)
                        //let y =   debut + CGFloat(Int(courbes.maxi.rounded(.up)) - index ) * ecart
                        Text("\(index)")
                            .font(.headline)
                            //.offset(x: 1.0, y: -CGFloat(CGFloat(index - bas) * ecart1))
                        //.position(x:10)
                    }
                }// Vstack
                .padding(.horizontal, 20)
            }
            //Spacer()
        }
        
        
    }
}

struct AbcissesView_Previews: PreviewProvider {
    static var previews: some View {
        AbcissesView()
    }
}
