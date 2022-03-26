//
//  ElemListeCardioBis.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 26/03/2022.
//

import SwiftUI

struct ElemListeCardioBis: View {
    var ligne1:String
    var ligne2: String
    
    @State var pulse = false
    
  
    
    var body: some View {
        HStack{
            Image(systemName: SYMBOLE_COEUR)
                
                .font(.system(size: 35, weight: .medium, design: .rounded) )
                .foregroundColor(.red)
                .scaleEffect(pulse ? 1.1 : 0.9)
            
                //.animation(.easeInOut(duration: 1).repeatForever(autoreverses: true) )
            
            VStack(alignment: .leading, spacing: 4){
                Text(ligne1)
                    .font(.system(size: 16, weight: .bold, design: .rounded) )
                    .foregroundColor(.blue)
                Text(ligne2)
                    .font(.system(size: 16, weight: .medium, design: .rounded) )
            }
            
        }
        .onAppear {
            //pulse.toggle()
            withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true) ) {
                pulse = true
            }
        }
    }
}

struct ElemListeCardioBis_Previews: PreviewProvider {
    static var previews: some View {
        ElemListeCardioBis(ligne1: "12/2/67 AM", ligne2: "12/2/67 AM")
    }
}
