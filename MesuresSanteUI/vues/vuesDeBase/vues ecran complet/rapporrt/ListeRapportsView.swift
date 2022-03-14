//
//  ListeRapportsView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 17/02/2022.
//

import SwiftUI

struct ListeRapportsView: View {
    
    // MARK: - Propriétéss
    @ObservedObject var patient : Personne
    
    @ObservedObject var datas : Mesures
    
    // MARK: - fonctions
    
    func removeRows(at offsets: IndexSet) {
        //patient.rapportsQuotidien.remove(atOffsets: offsets)
        patient.removeRapport(at: offsets)
    }
    
    // MARK: - body
    var body: some View {
        let rapports : [RapportQuotidien] = patient.rapportsQuotidien
        List {
            ForEach(rapports, id: \.id){(item) in
                ElemListePatient(patient: patient, datas: datas, rapport: item, ligne: "Rapport")
                    
            }
            .onDelete(perform: self.removeRows)
            
            /*
            rapport in
            ElemListePatient(patient: patient, datas: datas, rapport: rapport, ligne: "Rapport")
            */
            
            }
        
    }
}

struct ListeRapportsView_Previews: PreviewProvider {
    static var previews: some View {
        ListeRapportsView(patient: Personne(), datas: Mesures())
        //ListeRapportsView(patient: test, datas: Mesures())
    }
}
