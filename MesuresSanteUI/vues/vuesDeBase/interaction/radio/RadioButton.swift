//
//  RadioButton.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 15/03/2022.
//

import SwiftUI


struct RadioButton: View {
    
    var Texte : String = ""
    var tag : Int
    @Binding var choosed : Int
    @Binding var isChanged:Bool// = true
    var direction:Orientation = .droite

    
    var body: some View {
        Button {
            choosed = tag
            isChanged = choosed == tag
        } label: {
            HStack {
                if direction == .gauche {
                    Image(systemName: choosed == tag ?"largecircle.fill.circle" : "circle")
                    Text(Texte)
                } else {
                    Text(Texte)
                    //Spacer()
                    Image(systemName: choosed == tag ?"largecircle.fill.circle" : "circle")
                }
                
                    
            }
            
            /*
            .font(.system(size: 20, weight: .medium, design: .rounded))
            .foregroundColor(.black)
            */
        }

    }
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(Texte: "Sujet : ", tag: 1, choosed: .constant(1), isChanged: .constant(false), direction: .droite)
        //RadioButton(isChanged: .constant(true))
    }
}

enum Orientation {
    case haut, bas, droite, gauche
}
