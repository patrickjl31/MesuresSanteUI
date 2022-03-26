//
//  TitreBleuModifier.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 13/03/2022.
//

import SwiftUI

struct TitreBleuModifier: ViewModifier {
    
    //private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    func body(content: Content) -> some View {
        content
            
            .font(.system(size: (idiom == .pad ? 34 : 20), weight: .heavy, design: .rounded))
            .foregroundColor(Color("BleuSombre"))
            .shadow(color: Color("BlackLigth"), radius: 2, x: 1, y: 4)
    }
}

