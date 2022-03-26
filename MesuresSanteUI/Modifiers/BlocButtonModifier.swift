//
//  BlocButtonModifier.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 25/03/2022.
//

import Foundation
import SwiftUI

struct BlocButtonModifier: ViewModifier {
    //private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: (idiom == .pad ? 34 : 20), weight: .heavy, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal, 40)
            .padding(.vertical, 5)
            .background(LinearGradient(gradient: Gradient(colors: [Color("BleuClair"), Color("BleuSombre")]), startPoint: .top, endPoint: .bottom))
            //.background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
