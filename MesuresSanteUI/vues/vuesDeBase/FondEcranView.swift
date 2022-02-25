//
//  FonEcranView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 12/02/2022.
//

import SwiftUI

struct FondEcranView: View {
    
    @State var pulse:Bool = false
    
    var body: some View {
        
        VStack {
            /*
            Image("coeur2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 100, alignment: .center)
                .opacity(0.3)
             */
            Spacer()
            Image("coeur1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 350, alignment: .center)
            /*
                .opacity(pulse ? 0.4 : 0.2)
                .scaleEffect(pulse ? 1.1 : 0.8)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true) )
            */
            Spacer()
        }
        .onAppear(){
            pulse.toggle()
        }
        
    }
}

struct FondEcranView_Previews: PreviewProvider {
    static var previews: some View {
        FondEcranView()
    }
}
