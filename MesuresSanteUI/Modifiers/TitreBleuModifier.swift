//
//  TitreBleuModifier.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 13/03/2022.
//

import SwiftUI

struct TitreBleuModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .heavy, design: .rounded))
            .foregroundColor(Color("BleuSombre"))
            .shadow(color: Color("BlackLigth"), radius: 0, x: 0, y: 4)
    }
}

