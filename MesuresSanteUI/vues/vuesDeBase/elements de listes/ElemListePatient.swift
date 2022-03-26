//
//  ElemListePatient.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 16/02/2022.
//

import SwiftUI

struct ElemListePatient: View {
    
    @ObservedObject var patient : Personne
    
    //@ObservedObject var datas : Mesures
    
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
        
        ZStack{
            HStack{
                /*
                 */
                Image(systemName: "cross.case")
                    
                    .font(.system(size: 24, weight: .medium, design: .rounded) )
                    .foregroundColor(.red)
                    .scaleEffect(pulse ? 1.1 : 0.9)
                    //.animation(.easeInOut(duration: 1).repeatForever(autoreverses: true) )
                
                VStack(alignment: .leading, spacing: 4){
                    Text(laDate(date:rapport.date))
                        .font(.system(size: 16, weight: .bold, design: .rounded) )
                        .foregroundColor(.blue)
                    let moral = (rapport.moral.count > 0) ? "moral :  \(rapport.moral), " : ""
                    let cutane = (rapport.etatCutane.count > 0) ? "état cutané :  \(rapport.etatCutane), " : ""
                    let temperature = String(format: "température: %.1f °", rapport.temperature)
                    let diurese = String(format: "diurèse : %.1f l", rapport.diurese)
                    Text("\(ligne) :  \(moral) \(cutane)  \(temperature), douleur : \(rapport.douleur), \(diurese)" )
                        .font(.system(size: 12, weight: .medium, design: .rounded)
                        
                        //, specifier: "%.\(0.1)°"
                        )
                    
                }
                .frame(minWidth: 300, idealWidth: 350, maxWidth: .infinity)
                
                //Spacer()
                /*
                 */
                NavigationLink(destination: {
                    //RapportDuJourView(patient: patient, datas: datas)
                   DetailRapportView(patient: patient, rapport: rapport)
                }, label: {
                    /*
                    VStack {
                        Image(systemName: "eye")
                            .font(.system(size: 18, weight: .medium, design: .rounded) )
                            .foregroundColor(.pink)
                            
                        Text("Voir")
                            .font(.system(size: 12, weight: .light, design: .rounded) )
                            .foregroundColor(.red)
                    }
                    */
                })
            }
            .onAppear {
                //pulse.toggle()
                withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true) ) {
                    pulse = true
                }
        }
        }
    }
}

struct ElemListePatient_Previews: PreviewProvider {
    static var previews: some View {
        ElemListePatient(patient: Personne(), rapport: RapportQuotidien(),  ligne: "Vos selles")
    }
}
