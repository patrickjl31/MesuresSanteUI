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
    
    //@ObservedObject var datas : Mesures
    
    // MARK: - fonctions
    //Exporter avec airdrop
    func airportActionSheet(texte:String = "désolé") {
        //guard let data = URL(string: "https://www.zoho.com") else { return }
        let data = texte
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
    
    func removeRows(at offsets: IndexSet) {
        //patient.rapportsQuotidien.remove(atOffsets: offsets)
        patient.removeRapport(at: offsets)
    }
    
    // MARK: - body
    var body: some View {
        let rapports : [RapportQuotidien] = patient.rapportsQuotidien
        //NavigationView {
        VStack {
            Text("Vos constantes...")
                .modifier(MyTitleModifier())
                Text("Tous les rapports quotidiens")
                .modifier(TitreBleuModifier())
            List {
                    ForEach(rapports, id: \.id){(item) in
                        ElemListePatient(patient: patient, rapport: item, ligne: "Rapport")
                            
                    }
                    .onDelete(perform: self.removeRows)
                    
                    /*
                    rapport in
                    ElemListePatient(patient: patient, datas: datas, rapport: rapport, ligne: "Rapport")
                    */
                    
                }
            .listStyle(.grouped)
        }
        //}
        

        
        
        
        
    }
    

}

struct ListeRapportsView_Previews: PreviewProvider {
    static var previews: some View {
        ListeRapportsView(patient: Personne())
        //ListeRapportsView(patient: test, datas: Mesures())
    }
}
