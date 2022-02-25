//
//  MacHelp.swift
//  tension (iOS)
//
//  Created by patrick lanneau on 30/12/2020.
//

import SwiftUI

struct MacHelp: View {
    var body: some View {
        ScrollView(.vertical) {
            TextBlocWithTitle(texte0: T0_HELP1, texte1: T1_HELP1, texte2: HELP1)
            TextBlocWithTitle(texte0: T0_HELP2, texte1: T1_HELP2, texte2: HELP2)
            TextBlocWithTitle(texte0: T0_HELP3, texte1: T1_HELP3, texte2: HELP3)
            TextBlocWithTitle(texte0: T0_HELP4, texte1: T1_HELP4, texte2: HELP4)
        }
    }
}

struct MacHelp_Previews: PreviewProvider {
    static var previews: some View {
        MacHelp()
    }
}
