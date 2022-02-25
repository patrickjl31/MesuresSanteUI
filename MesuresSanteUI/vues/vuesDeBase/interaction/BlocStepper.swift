//
//  BlocStepper.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 16/02/2022.
//

import SwiftUI

struct BlocStepper: View {
    
    var texte : String = "Selles "
    var maxi : Int = 10
    @Binding var valeur : Int
    var couleur : Color = .black
    //@State var valeur : Int = 0
    
    var body: some View {
        Stepper("\(texte) : \(valeur)", value: $valeur, in: 0...maxi)
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .foregroundColor(couleur)
            .padding(.horizontal, 10)
            //.padding(.vertical,10)
        
    }
}

struct BlocStepper_Previews: PreviewProvider {
    static var previews: some View {
        BlocStepper( valeur: .constant(0))
    }
}
