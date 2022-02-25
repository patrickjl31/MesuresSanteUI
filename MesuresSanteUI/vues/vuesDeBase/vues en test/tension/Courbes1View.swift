//
//  Courbes1View.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 20/02/2022.
//

import SwiftUI

struct Courbes1View: View {
    
    @ObservedObject var patient : Personne
    @ObservedObject var datas : Mesures
    
    
    var body: some View {
        ZStack {
            
            VStack{  
                TitulatureView(titreSpecifique: "Vos mesures en courbes...")
                PeriodeView(patient: patient)
                    //.offset(x: 0, y: -30)
                
                // Tracé des courbes
                Spacer()
                
                //Spacer()
            }
            
            LargeGraphicView(patient: patient, datas: datas, hauteur: 800)
        }
    }
}

struct Courbes1View_Previews: PreviewProvider {
    static var previews: some View {
        Courbes1View(patient: Personne(), datas: Mesures())
    }
}
