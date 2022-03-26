//
//  TextBlocWithTitle.swift
//  tension (iOS)
//
//  Created by patrick lanneau on 30/12/2020.
//

import SwiftUI

struct TextBlocWithTitle: View {
    var texte0: String
    var texte1: String
    var texte2: String
    
    var body: some View {
        VStack {
            Text(texte0)
                .font(.title)
                .foregroundColor(.red)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
            Text(texte1)
                .font(.title2)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .fontWeight(.semibold)
                .padding()
            Text(texte2)
                .font(.system(size: idiom == .pad ? 22 : 14, weight: .medium, design: .rounded))
                .padding()
        }
        //.background(Color("grisClair"))
    }
}

struct TextBlocWithTitle_Previews: PreviewProvider {
    static var previews: some View {
        TextBlocWithTitle(texte0: T0_HELP1, texte1: T1_HELP1, texte2: HELP1)
            .previewLayout(.sizeThatFits)
    }
}
