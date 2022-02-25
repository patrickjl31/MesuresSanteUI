//
//  SaisieDate.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 13/02/2022.
//

import SwiftUI

struct SaisieDate: View {
    
    //@Binding var moment: String = ""
    
    @State private var autreJour : Bool = false
    @Binding var releveDu : Date
    
    
    var body: some View {
        
        VStack {
            
            Toggle("Saisir le relevé d'un autre jour ?", isOn: $autreJour)
                //.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .tint(.blue)
                
            if autreJour {
                DatePicker(selection: $releveDu,
                    label: { Text("Relevés du :") })
                                }
            else {
                Text("Mesures réalisées le \(releveDu.identDateAndMoment().date) (\(releveDu.identDateAndMoment().moment))")
                
            }
        }
        .font(.system(size: 18, weight: .bold, design: .rounded))
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct SaisieDate_Previews: PreviewProvider {
    static var previews: some View {
        SaisieDate(releveDu: .constant(Date()))
    }
}
