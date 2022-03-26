//
//  TousLesRapports.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 26/02/2022.
//

import SwiftUI

struct TousLesRapports: View {
    
    @ObservedObject var patient : Personne
    
    
    // MARK: - Fonctions
    func laDate(date:Date)->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "FR-fr")
        format.dateFormat = "EEEE dd MMMM yyyy"
        return format.string(from: date)
        
    }
    
    
    //Exporter avec airdrop
    func airportActionSheet(texte:String = "désolé") {
        //guard let data = URL(string: "https://www.zoho.com") else { return }
        let data = texte
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        //UIWindowScene.windows
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
    
    var body: some View {
        VStack {
            //HStack{
                Text("Rapports enregistrés ")
                .modifier(TitreBleuModifier())
                if patient.rapportsQuotidien.count > 1{
                    Text( "du \(laDate( date: patient.rapportsQuotidien.first!.date)) au \(laDate( date: patient.rapportsQuotidien.last!.date))")
                        .modifier(PetitBleuModifier())
                }
            
            //}
            
                
            
            ScrollView(.horizontal, showsIndicators: true){
                HStack {
                    ForEach((0..<patient.rapportsQuotidien.count),id: \.self){index in
                        DetailRapportView(patient: patient, rapport: patient.rapportsQuotidien[index])
                    }
                }
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    //datas.deleteAll()
                    let unRapport = patient.rapportToJson()
                    if unRapport != nil {
                        airportActionSheet(texte: unRapport!)
                    }
                    
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title)
                    Text("Exporter")
                })
                .padding(20)
            }
            
        }
    }
}

struct TousLesRapports_Previews: PreviewProvider {
    static var previews: some View {
        TousLesRapports(patient: Personne())
    }
}
