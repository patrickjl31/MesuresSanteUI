//
//  ItaliqueBleuModifier.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 19/03/2022.
//

import SwiftUI

struct ItaliqueBleuModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .medium, design: .rounded).italic())
            .foregroundColor(Color("BleuSombre"))
            .shadow(color: Color("BlackLigth"), radius: 2, x: 1, y: 4)
    }
}

