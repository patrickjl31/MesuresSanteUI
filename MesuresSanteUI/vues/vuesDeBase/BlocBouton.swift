//
//  BlocBouton.swift
//  TestVitesseImportUI
//
//  Created by patrick lanneau on 27/05/2020.
//  Copyright © 2020 patrick lanneau. All rights reserved.
//

import SwiftUI

struct BlocBouton: View {
    
    var texte : String
    
    var body: some View {

        
        HStack(alignment:.center) {
            //Spacer()
            Text(self.texte)
                .font(.system(size: 16, weight:
                    .black, design: .default))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .frame(width: 200, height: 20, alignment: .center)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .background(Color("BleuSombre"))
                .cornerRadius(20)
                .shadow(color: .black, radius: 4, x: 4, y: 4)
            /*
                .overlay(Capsule()
                            //.fill(.clear)
                            .stroke(Color.brown, lineWidth : 6)
                         
                )
                .padding()
             */
            //Spacer()
        }
        
    }
}

struct BlocBouton_Previews: PreviewProvider {
    static var previews: some View {
        BlocBouton(texte: /*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .previewLayout(.sizeThatFits)
    }
}
