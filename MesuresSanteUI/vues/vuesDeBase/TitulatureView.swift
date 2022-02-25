//
//  TitulatureView.swift
//  tension
//
//  Created by patrick lanneau on 11/01/2021.
//

import SwiftUI

struct TitulatureView: View {
    var titreSpecifique : String = "Vos mesures..."
    
    @State var anim : Bool = false
    var body: some View {
        VStack(spacing: 0, content: {
            Image("coeur2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 50, alignment: .center)
            Text(titreSpecifique)
                .font(.title)
                .foregroundColor(Color("BleuNoir"))
            Image("coeur1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.opacity(0.8)
                .frame(width: 100, height: 80, alignment: .center)
                .scaleEffect(anim ? 1 : 0.8)
                //.animation(.easeInOut(duration: 1) .repeatForever(autoreverses: true))
                .onAppear {
                    let baseAnimation = Animation.easeInOut(duration: 1)
                    let repeated = baseAnimation.repeatForever(autoreverses: true)

                    withAnimation(repeated) {
                        anim = true
                    }
                }
           
            //Spacer()
        })
    }
}

struct TitulatureView_Previews: PreviewProvider {
    static var previews: some View {
        TitulatureView()
    }
}
