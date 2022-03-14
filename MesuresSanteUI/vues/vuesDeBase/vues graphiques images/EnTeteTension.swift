//
//  EnTeteTension.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 18/02/2022.
//

import SwiftUI

struct EnTeteTension: View {
    var body: some View {
        VStack {
            Image("coeur2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 70, alignment: .center)
                .opacity(0.6)
            Text("Surveillez votre tension...")
                .font(.system(size: 18, weight: .heavy, design: .rounded))
            .foregroundColor(Color("BleuSombre"))
        }
    }
}

struct EnTeteTension_Previews: PreviewProvider {
    static var previews: some View {
        EnTeteTension()
    }
}
