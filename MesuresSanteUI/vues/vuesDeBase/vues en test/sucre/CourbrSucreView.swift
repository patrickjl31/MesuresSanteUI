//
//  CourbrSucreView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 24/02/2022.
//

import SwiftUI

struct CourbrSucreView: View {
    
    @ObservedObject var patient : Personne
    @ObservedObject var datas : Mesures
    
    
    var body: some View {
        ZStack {
            
            VStack{
                TitulatureView(titreSpecifique: "Votre glycémie en courbes...")
                PeriodeView(patient: patient)
                    //.offset(x: 0, y: -30)
                
                // Tracé des courbes
                Spacer()
                
                //Spacer()
            }
            
            LargeGraphicSucre(patient: patient, datas: patient.diabete)
        }
    }
}

struct CourbrSucreView_Previews: PreviewProvider {
    static var previews: some View {
        CourbrSucreView(patient: Personne(), datas: Mesures())
    }
}
