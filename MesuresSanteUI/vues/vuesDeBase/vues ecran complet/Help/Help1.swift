//
//  Help1.swift
//  tension (iOS)
//
//  Created by patrick lanneau on 27/12/2020.
//

import SwiftUI

struct Help1: View {
    
    var body: some View {
        
        TextBlocWithTitle(texte0: T0_HELP1, texte1: T1_HELP, texte2: HELP)
        
//        let texte0 = "Surveillez votre tension artérielle..."
//        let texte1 = "Votre santé en dépend."
//        let texte2 = """
//
//
//        Tension est un outil à votre disposition pour assurer le suivi de votre tension.
//        Il vous permet d'enregistrer vos mesures (Tension systolique, tension distolique, fréquence cardiaque) à un moment donné, puis , de les présenter  sous forme graphique.
//        """
//
//        VStack {
//            Text(texte0)
//                .font(.title)
//                .foregroundColor(.red)
//                .fontWeight(.black)
//                .multilineTextAlignment(.center)
//            Text(texte1)
//                .font(.title2)
//                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                .fontWeight(.semibold)
//                .padding()
//            Text(texte2)
//                .padding()
//        }
    }
}

struct Help1_Previews: PreviewProvider {
    static var previews: some View {
        Help1()
    }
}
