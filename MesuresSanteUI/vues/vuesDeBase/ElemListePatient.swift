//
//  ElemListePatient.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 16/02/2022.
//

import SwiftUI

struct ElemListePatient: View {
    
    @ObservedObject var patient : Personne
    
    @ObservedObject var datas : Mesures
    
    var rapport : RapportQuotidien
    var ligne : String = ""
    
    @State var pulse = false
    
    // MARK: - Fonctions
    func laDate(date:Date)->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "FR-fr")
        format.dateFormat = "EEEE dd MMMM yyyy"
        return format.string(from: Date())
        
    }
    
    var body: some View {
        
        HStack{
            Image(systemName: "cross.case")
                
                .font(.system(size: 35, weight: .medium, design: .rounded) )
                .foregroundColor(.red)
                .scaleEffect(pulse ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true) )
            
            VStack(alignment: .leading, spacing: 4){
                Text(laDate(date:rapport.date))
                    .font(.system(size: 16, weight: .bold, design: .rounded) )
                    .foregroundColor(.blue)
                Text("\(ligne) : \(rapport.selles)" )
                    .font(.system(size: 16, weight: .medium, design: .rounded) )
            }
            
            Spacer()
            
            NavigationLink(destination: {
                //RapportDuJourView(patient: patient, datas: datas)
               DetailRapportView(patient: patient, rapport: rapport)
            }, label: {
                VStack {
                    Image(systemName: "eye")
                        .font(.system(size: 28, weight: .medium, design: .rounded) )
                        .foregroundColor(.pink)
                        
                    Text("Voir")
                        .font(.system(size: 16, weight: .light, design: .rounded) )
                        .foregroundColor(.red)
                }
                
                
            })
            
        }
        .onAppear {
            pulse.toggle()
        }
    }
}

struct ElemListePatient_Previews: PreviewProvider {
    static var previews: some View {
        ElemListePatient(patient: Personne(), datas: Mesures(), rapport: RapportQuotidien(),  ligne: "Vos selles")
    }
}
