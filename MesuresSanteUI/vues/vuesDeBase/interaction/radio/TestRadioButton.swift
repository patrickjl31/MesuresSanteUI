//
//  TestRadioButton.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 16/03/2022.
//

import SwiftUI

struct TestRadioButton: View {
    @State var choosed : Int = 0
    
    var body: some View {
        RadioButtonsView(questions: ["Choix0","Choix1","Choix2","Choix3","Choix4"], choosed: $choosed, nbColones: 2)
    }
}

struct TestRadioButton_Previews: PreviewProvider {
    static var previews: some View {
        TestRadioButton()
    }
}
