//
//  DemandeDouble.swift
//  tension (iOS)
//
//  Created by patrick lanneau on 07/12/2020.
//

import SwiftUI


struct DemandeDouble: View {
    
    var titre:String
    @Binding var valeur:Double
    var mini:Double
    var maxi : Double
    var pas : Double = 0.1
    var couleur : Color = .blue
    var precision : Int = 1
    var body: some View {
        VStack {
            let codeDigits = "%.\(precision)f"
            Text("\(titre) : \(valeur, specifier: codeDigits)")
                .foregroundColor(couleur)
            HStack {
                Text("\(mini, specifier: codeDigits)")
                    .foregroundColor(couleur)
                Slider(value: $valeur, in: mini...maxi, step: pas)
                    
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                    .accentColor(couleur)
                    
                Text("\(maxi, specifier: codeDigits)")
                    .foregroundColor(couleur)
            }
            
        }
        
    }
    
    
}

struct DemandeDouble_Previews: PreviewProvider {
    static var previews: some View {
        DemandeDouble(titre: "Systolique", valeur: .constant(12), mini: 3, maxi: 30, couleur: .pink)
    }
}
