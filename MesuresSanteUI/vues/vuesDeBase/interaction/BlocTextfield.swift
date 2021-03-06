//
//  BlocTextfile.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 16/02/2022.
//

import SwiftUI

struct BlocTextfield: View {
    
    @Binding var reponse : String
    var message : String = ""
    var placeHolder :String = ""
    var couleur:Color = .black
    
    var body: some View {
        HStack {
            Text(message)
            TextField(placeHolder,
                      text: $reponse)
               
        }
        .font(.system(size: (idiom == .pad ? 24 : 14), weight: .bold, design: .rounded))
        .foregroundColor(couleur)
        .padding(.horizontal, 10)
        
           
    }
}

struct BlocTextfield_Previews: PreviewProvider {
    static var previews: some View {
        BlocTextfield(reponse: .constant("Demande"), message: "Demande ?")
    }
}
