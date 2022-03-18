//
//  ModifierRadioButtons.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 16/03/2022.
//

import SwiftUI


struct RadioButtonsModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular, design: .rounded))
            .foregroundColor(Color("BleuSombre"))
            .shadow(color: Color("BlackLigth"), radius: 3, x: 0, y: 4)
            //.padding(.bottom, 10)
    }
}

