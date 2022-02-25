//
//  EnTeteSucre.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 18/02/2022.
//

import SwiftUI

struct EnTeteSucre: View {
    
    //@State var pulse:Bool = false
    
    var body: some View {
        VStack {
            Image("sucre5")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 70, alignment: .center)
                .opacity(0.6)
            Text("Surveillez votre taux de sucre...")
                .font(.system(size: 18, weight: .heavy, design: .rounded))
            .foregroundColor(Color("BleuSombre"))
        }
        
        
    }
}

struct EnTeteSucre_Previews: PreviewProvider {
    static var previews: some View {
        EnTeteSucre()
    }
}
