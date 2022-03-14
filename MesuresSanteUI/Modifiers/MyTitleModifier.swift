//
//  MyTitleModifier.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 13/03/2022.
//

import SwiftUI

struct MyTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

