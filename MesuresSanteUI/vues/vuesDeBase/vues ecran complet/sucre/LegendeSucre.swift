//
//  LegendeSucre.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 28/02/2022.
//

import SwiftUI

struct LegendeSucre: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
                    Text("Légende : ")
                        .foregroundColor(.black)
                    //Spacer()
                    Text("Sucre ")
                        .foregroundColor(COUL_SYSTO)
                    
                    //Text("Diastolique")
                        //.foregroundColor(COUL_DIASTO)
                    //Spacer()
                } // HStack
                .font(.title3)
    }
}

struct LegendeSucre_Previews: PreviewProvider {
    static var previews: some View {
        LegendeSucre()
    }
}
