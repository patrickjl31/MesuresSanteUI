//
//  ModifierRadioButtons.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 16/03/2022.
//

import SwiftUI


struct RadioButtonsModifier: ViewModifier {
    //private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    func body(content: Content) -> some View {
        content
            .font(.system(size: (idiom == .pad ? 20 : 12), weight: .bold, design: .rounded))
            //.font(.system(size: 12, weight: .bold, design: .rounded))
            //.font(.subheadline)
            //.font(.system(weight: .regular, design: .rounded))
            .foregroundColor(Color("BleuSombre"))
            .shadow(color: Color("BlackLigth"), radius: 3, x: 0, y: 4)
            //.padding(.bottom, 10)
    }
}

