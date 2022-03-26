//
//  CoeurBattantView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 26/03/2022.
//

import SwiftUI

struct CoeurBattantView: View {
    
    @State private var pulse = false
    
    var body: some View {
        Image("coeur1")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            .scaleEffect(pulse ? 1.1 : 1)
            .opacity(pulse ? 1 : 0.8)
            .onAppear(){
                //pulse.toggle()
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true))
                {
                    pulse = true
                    //pulse.toggle()
                }
            }
    }
}

struct CoeurBattantView_Previews: PreviewProvider {
    static var previews: some View {
        CoeurBattantView()
    }
}
