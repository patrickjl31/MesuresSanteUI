//
//  SaisieConstantes.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 12/02/2022.
//

import SwiftUI

struct SaisieConstantes: View {
    
    @ObservedObject var patient : Personne
    //@ObservedObject var datas : Mesures
    
    
    var body: some View {
        ZStack{
            FondEcranView()
        }
    }
}

struct SaisieConstantes_Previews: PreviewProvider {
    static var previews: some View {
        SaisieConstantes(patient: Personne())
    }
}
