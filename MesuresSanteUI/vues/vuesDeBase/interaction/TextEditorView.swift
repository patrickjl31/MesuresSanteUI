//
//  TextEditorView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 17/02/2022.
//

import SwiftUI

struct TextEditorView: View {
    
    @Binding var remarques:String
    
    var body: some View {
        TextEditor( text: $remarques)
            .foregroundColor(.black)
            //.background(Color.blue)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            //.background(Color.yellow)
            .colorMultiply(Color("JauneClair"))
            .border(Color.blue)
            .cornerRadius(20)
            
            
            .frame(minWidth: 150, maxWidth: 450, minHeight: 0, maxHeight: 100)
            
            .padding(.horizontal, 10)
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(remarques: .constant("Remarques"))
    }
}
