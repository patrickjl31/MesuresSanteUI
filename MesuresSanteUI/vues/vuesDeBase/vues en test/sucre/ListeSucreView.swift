//
//  ListeSucreView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 18/02/2022.
//

import SwiftUI

struct ListeSucreView: View {
    // MARK: - Propriétéss
    @ObservedObject var patient : Personne
    
    @ObservedObject var datas : Mesures
    

    
    // MARK: - Fonctions
    func laDate(date:Date)->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "FR-fr")
        format.dateFormat = "EEEE dd MMMM yyyy"
        return format.string(from: date)
        
    }
    
    
    func removeRows(at offsets: IndexSet) {
        //patient.rapportsQuotidien.remove(atOffsets: offsets)
        //patient.removeRapport(at: offsets)
    }
    
    // MARK: - body
    var body: some View {
        ZStack{
            FondEcranSucreView()
            
            
            VStack {
                let sucres : [MesureSucre] = patient.diabete.sucre
                EnTeteSucre()
                List {
                    ForEach(sucres, id: \.id){(item) in
                        let l1 = laDate(date: item.dateMesure)
                        let l2 = "Glycémie : "
                        ElemListeSucre(ligne1: l1, ligne2: l2, valeur: item.taux)
                            
                    }
                    .onDelete(perform: self.removeRows)
                    /*
                    rapport in
                    ElemListePatient(patient: patient, datas: datas, rapport: rapport, ligne: "Rapport")
                    */
                    
                }
            }// VStack
            
        }

            
            
            
        }

}

struct ListeSucreView_Previews: PreviewProvider {
    static var previews: some View {
        ListeSucreView(patient: Personne(), datas: Mesures())
    }
}
