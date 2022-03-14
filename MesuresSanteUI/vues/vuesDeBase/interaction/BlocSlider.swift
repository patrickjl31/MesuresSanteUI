//
//  BlocSlider.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 16/02/2022.
//

import SwiftUI

struct BlocSlider: View {
    var texte : String = ""
    @Binding var valeur : Double
    @State var isChanged : Bool = false
    var mini:Double = 0.1
    var maxi : Double = 100.0
    
    var pas : Double = 0.1
   
    
    var couleur : Color = .blue
    
    var body: some View {
        VStack {
            let precision : String = (pas < 1.0 ? "%.1f" : "%.0f")
            //Text("\(texte) : \(valeur, specifier: "%.2f")")
            
            Text("\(texte) : \(valeur, specifier: precision)")
            
            HStack {
                Text("\(mini, specifier: precision)")
                    .foregroundColor(couleur)
                Slider(value: $valeur, in: mini...maxi, step: pas) {
                    Text("Valeur")
                } onEditingChanged: { changed in
                        isChanged = changed
            }
            Text("\(maxi, specifier: precision)")
            } // HStack

        }//VStack
        .foregroundColor(couleur)
        .font(.system(size: 18, weight: .bold, design: .rounded))
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .accentColor(couleur)
                        
    }
}

struct BlocSlider_Previews: PreviewProvider {
    static var previews: some View {
        BlocSlider( texte: "pipi : ", valeur: .constant(20), pas: 0.1)
        //BlocSlider( texte: "pipi : ", valeur: .constant(2), pas: 1)
    }
}
