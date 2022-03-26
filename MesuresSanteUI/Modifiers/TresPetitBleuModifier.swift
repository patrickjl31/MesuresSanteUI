//
//  TresPetitBleuModifier.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 25/03/2022.
//

import Foundation
import SwiftUI

struct TresPetitBleuModifier: ViewModifier {
    //private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    func body(content: Content) -> some View {
        content
            
            .font(.system(size: (idiom == .pad ? 20 : 12), weight: .bold, design: .rounded))
            .foregroundColor(Color("BleuSombre"))
            .shadow(color: Color("BlackLigth"), radius: 2, x: 1, y: 4)
    }
}
