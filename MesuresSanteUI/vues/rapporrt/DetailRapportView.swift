//
//  DetailRapportView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 17/02/2022.
//

import SwiftUI

struct DetailRapportView: View {
    
    @ObservedObject var patient : Personne
    
    
    // MARK: - Fonctions
    func laDate(date:Date)->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "FR-fr")
        format.dateFormat = "EEEE dd MMMM yyyy"
        return format.string(from: date)
        
    }
    
    
    var rapport : RapportQuotidien
    
    var body: some View {
        
        ScrollView(.horizontal) {
            VStack(alignment: .center, spacing: 10){
                Text("Rapport du : \(laDate(date: date))")
                    .font(.system(size: 24, weight: .heavy, design: .rounded))
                        .foregroundColor(Color("BleuSombre"))
                        .shadow(color: Color("BlackLigth"), radius: 4, x: 4, y: 4)
                        .padding(.vertical, 20)
                Divider()
                HStack {
                    Text("Température : ")
                    Spacer()
                    Text("\(rapport.temperature,  specifier: "%.1f") °")
                }
                HStack {
                    Text("Diurèse : ")
                    Spacer()
                    Text("\(rapport.diurese,  specifier: "%.1f") litres.")
                }
                HStack {
                    Text("Selles : ")
                    Spacer()
                    Text("\(rapport.selles,  specifier: "%f0.0") ")
                }
                HStack {
                    Text("Douleur : ")
                    Spacer()
                    Text("\(rapport.douleur,  specifier: "%.0f") (échelle de 0 à 10)).")
                }
                Group {
                    HStack(alignment: .top) {
                        Text("Etat cutané : ")
                        Spacer()
                        Text("\(rapport.etatCutane)")
                    }
                    
                    HStack (alignment: .top){
                        Text("Moral : ")
                        Spacer()
                        Text("\(rapport.etatCutane)")
                                }
                    HStack(alignment: .top) {
                        Text("Remarques diverses : ")
                        Spacer()
                        Text("\(rapport.remarques)")
                    }
                    

                    
                    
                }
                .lineLimit(10)
                
            }
            .foregroundColor(Color("BleuSombre"))
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .accentColor(Color("BleuSombre"))
        }
    }
}

struct DetailRapportView_Previews: PreviewProvider {
    static var previews: some View {
        DetailRapportView(patient: Personne(), rapport: RapportQuotidien())
    }
}


/*
 var id = UUID()
 var date = Date()
 var selles : Int = 0
 var diurese: Double = 0.0 //pipi
 var douleur : Int = 0
 var temperature : Double = 37.9
 var etatCutane:String = ""
 var moral : String = ""
 var remarques : String = ""
 
 */
