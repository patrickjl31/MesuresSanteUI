//
//  ElemListeSucre.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 18/02/2022.
//

import SwiftUI

struct ElemListeSucre: View {
    var ligne1:String
    var ligne2: String
    var valeur : Double
    
    @State var pulse = false
    
  
    
    var body: some View {
        HStack{
            Image(systemName: "cup.and.saucer")
                
                .font(.system(size: 35, weight: .medium, design: .rounded) )
                .foregroundColor(.red)
                .scaleEffect(pulse ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true) )
            
            VStack(alignment: .leading, spacing: 4){
                Text(ligne1)
                    .font(.system(size: 16, weight: .bold, design: .rounded) )
                    .foregroundColor(.blue)
                Text("\(ligne2) : \(valeur, specifier: "%.3f")")
                    .font(.system(size: 16, weight: .medium, design: .rounded) )
            }
            
        }
        .onAppear {
            pulse.toggle()
        }
    }
}

struct ElemListeSucre_Previews: PreviewProvider {
    static var previews: some View {
        ElemListeSucre(ligne1: "Ligne &", ligne2: "Ligne &", valeur: 4.8765)
    }
}
