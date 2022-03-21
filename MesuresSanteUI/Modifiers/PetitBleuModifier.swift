//
//  PetitBleuModifier.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 20/03/2022.
//

import SwiftUI

struct PetitBleuModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            
            .font(.system(size: 14, weight: .bold, design: .rounded))
            .foregroundColor(Color("BleuSombre"))
            .shadow(color: Color("BlackLigth"), radius: 2, x: 1, y: 4)
    }
}

