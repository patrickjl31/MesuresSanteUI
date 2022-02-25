//
//  DoubleSliderView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 13/02/2022.
//

import SwiftUI

struct DoubleSliderView: View {
    
    @Binding var valeur : Double
    
    var titre1:String = "Choix : "
    var titre2:String = "Choix : "
    
    var mini1:Double = 0.1
    var maxi1 : Double = 10.0
    var mini2:Double = 0.1
    var maxi2 : Double = 150.0
    
    var pas : Double = 0.01
    var precision : Int = 2
    
    var couleur1 : Color = .blue
    var couleur2 : Color = .red
    
    @State var val1:Double = 1.0
    @State var val2:Double = 20
    
    // MARK: - Fonctions
    func evalPas(precision : Int)->Double{
        var res:Double = 1
        for i in 1...precision {
            res = res / 10
        }
        return res
    }
    
    
    var body: some View {
        VStack {
            let codeDigits = "%.\(precision)f"
            Text("\(titre1) : \(val1, specifier: codeDigits)")
                .foregroundColor(couleur1)
            HStack {
                Text("\(mini1, specifier: codeDigits)")
                    .foregroundColor(couleur1)
                Slider(value: $val1, in: mini1...maxi1, step: pas) {
                    Text("Valeur")
                } onEditingChanged: { changed in
                    val2 = val1 * 14.5
                    valeur = val1
            }
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                .accentColor(couleur1)
                
                Text("\(maxi1, specifier: codeDigits)")
                    .foregroundColor(couleur1)
            } // HStack
            
            Divider()
            
            Text("\(titre2) : \(val2, specifier: codeDigits)")
                .foregroundColor(couleur2)
            HStack {
                Text("\(mini2, specifier: codeDigits)")
                    .foregroundColor(couleur2)
                Slider(value: $val2, in: mini2...maxi2, step: pas) {
                    Text("Valeur 2")
                } onEditingChanged: { changed in
                    val1 = val2 / 14.5
                    valeur = val1
            }
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                .accentColor(couleur2)
                
                Text("\(maxi2, specifier: codeDigits)")
                    .foregroundColor(couleur2)
                
            } // HStack
            
            Text("Valeur en G/L : \(valeur, specifier: codeDigits)")
            
        }
        .font(.system(size: 18, weight: .bold, design: .rounded))

    }
}

struct DoubleSliderView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleSliderView(valeur: .constant(2.0))
    }
}
