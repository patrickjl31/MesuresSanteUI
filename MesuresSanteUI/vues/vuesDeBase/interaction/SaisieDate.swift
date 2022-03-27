//
//  SaisieDate.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 13/02/2022.
//

import SwiftUI

struct SaisieDate: View {
    
    //@Binding var moment: String = ""
    
    
    @Binding var releveDu : Date
    @Binding var autreJour : Bool
    
    var maintenant = Date()
    
    func setDate(){
        releveDu = Date()
    }
    var body: some View {
        
        VStack {
            Text("Relevé du : \(releveDu.identDateAndMoment().date)  (\(releveDu.identDateAndMoment().moment))")
            Toggle("Saisir le relevé d'un autre jour ?", isOn: $autreJour)
                //.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .tint(.blue)
                .onChange(of: autreJour) { newValue in
                    if !newValue{
                        releveDu = Date()
                    }
                }
            
            if autreJour {
                DatePicker(selection: $releveDu,
                    label: { Text("Relevés du :") })
            }
            
        }
        .modifier(PetitBleuModifier())
        //.font(.system(size: 18, weight: .bold, design: .rounded))
        .padding(.horizontal, 10)
    }
}

struct SaisieDate_Previews: PreviewProvider {
    static var previews: some View {
        SaisieDate(releveDu: .constant(Date()), autreJour: .constant(true))
    }
}



/*
 
 
 VStack {
     
     Toggle("Saisir le relevé d'un autre jour ?", isOn: $autreJour)
         //.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
         .tint(.blue)
         
         .onChange(of: autreJour) { newValue in
             if newValue{
                 releveDu = Date()
                 Text("Mesures réalisées le \(releveDu.identDateAndMoment().date) (\(releveDu.identDateAndMoment().moment))")
             }
         }
     
     if autreJour {
         DatePicker(selection: $releveDu,
             label: { Text("Relevés du :") })
     }
     
 }
 //.font(.system(size: 18, weight: .bold, design: .rounded))
 .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
}
 
 
 
 
 */
