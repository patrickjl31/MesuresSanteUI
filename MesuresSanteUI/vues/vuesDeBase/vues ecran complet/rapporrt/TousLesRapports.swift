//
//  TousLesRapports.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 26/02/2022.
//

import SwiftUI

struct TousLesRapports: View {
    
    @ObservedObject var patient : Personne
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true){
            HStack {
                ForEach((0..<patient.rapportsQuotidien.count)){index in
                    DetailRapportView(patient: patient, rapport: patient.rapportsQuotidien[index])
                }
            }
        }
    }
}

struct TousLesRapports_Previews: PreviewProvider {
    static var previews: some View {
        TousLesRapports(patient: Personne())
    }
}
