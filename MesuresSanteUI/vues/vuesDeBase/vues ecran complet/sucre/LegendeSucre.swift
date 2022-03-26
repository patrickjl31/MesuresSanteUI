//
//  LegendeSucre.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 28/02/2022.
//

import SwiftUI

struct LegendeSucre: View {
    
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
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
                .font(.system(size: (idiom == .pad ? 20 : 12), weight: .bold, design: .rounded))
                //.font(.title3)
    }
}

struct LegendeSucre_Previews: PreviewProvider {
    static var previews: some View {
        LegendeSucre()
    }
}
