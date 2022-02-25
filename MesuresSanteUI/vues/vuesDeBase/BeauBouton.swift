//
//  beauBouton.swift
//  TestVitesseImportUI
//
//  Created by patrick lanneau on 27/04/2020.
//  Copyright © 2020 patrick lanneau. All rights reserved.
//

import SwiftUI



struct BeauBouton: View {
    let bleu_sombre : Color = Color(.sRGB, red: 140, green: 40, blue: 40, opacity: 1)
    var texte:String
    
    var body: some View {
        Text(texte)
            .foregroundColor(.white)
            .font(.body)
            .fontWeight(.bold)
            .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
            .border(Color.black, width: 2)
            .cornerRadius(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color("BleuSombre"),Color("BleuClair"),.white]), startPoint: .top, endPoint: .bottom))
            .shadow(color: .gray, radius: 3, x: 3, y: 3)
            
        
    }
}

struct BeauBouton_Previews: PreviewProvider {
    static var previews: some View {
        BeauBouton(texte: "Mon bouton")
            .previewLayout(.sizeThatFits)
    }
}
