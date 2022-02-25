//
//  FondEcranSucre.view.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 13/02/2022.
//

import SwiftUI

struct FondEcranSucreView: View {
    
    @State var pulse:Bool = false
    
    var body: some View {
        
        VStack {
            //EnTeteSucre()
            /*
            Image("sucre5")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 70, alignment: .center)
                .opacity(0.6)
           
            Text("Surveillez votre taux de sucre...")
                .font(.system(size: 18, weight: .heavy, design: .rounded))
                .foregroundColor(Color("BleuSombre"))
             */
            
            Spacer()
            Image("sucre2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 350, alignment: .center)
                .opacity(pulse ? 0.3 : 0.1)
                //.scaleEffect(pulse ? 1.1 : 0.8)
                //.animation(.easeInOut(duration: 1).repeatForever(autoreverses: true) )
            
            Spacer()
        }
        .onAppear(){
            //pulse.toggle()
        }
        
    }
}

struct FondEcranSucreView_Previews: PreviewProvider {
    static var previews: some View {
        FondEcranSucreView()
    }
}
