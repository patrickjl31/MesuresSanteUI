//
//  TensionBarView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 20/02/2022.
//

import SwiftUI

struct TensionBarView: View {
    
    @ObservedObject var patient : Personne
    //@ObservedObject var datas : Mesures
    
    var body: some View {
       
            
            VStack {
                TitulatureView(titreSpecifique: "Vos résultats en histogrammes...")
                Spacer()
            
                PeriodeView(patient: patient)
                if !patient.tension.noMesures() {
                // On affiche les barres
                //Text("Systolique ")
                
                Spacer()
                //ExtractedView(datas: datas)
                    //patient.tension
                ExtractedVievBar(datas: patient.tension, epaisseur: 40, coefHauteur: 25)
                // Fin scroll view
                    
                    
                    HStack(alignment: .center, spacing: 10) {
                        Text("Légende : ")
                                    .foregroundColor(.black)
                                //Spacer()
                        VStack{
                            HStack{
                                Text("AM : ")
                                Text("Systolique ")
                                    .foregroundColor(COUL_SYSTO)
                                
                                Text("Diastolique")
                                    .foregroundColor(COUL_DIASTO)
                            }
                            HStack{
                                Text("PM : ")
                                Text("Systolique ")
                                    .foregroundColor(COUL_SYSTO)
                                    .opacity(0.6)
                                
                                Text("Diastolique")
                                    .foregroundColor(COUL_DIASTO)
                                    .opacity(0.6)
                            }
                            
                        }
                        .font(.callout)
                            }
                            //.font(.title3)
            }
            
            /*_________________________________________________________
            HStack{
            VStack {
                //Spacer(minLength: 800)
                // Share Sheet
                Button(action: { self.shareSheetIsPresented = true }) {
                    VStack {
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 44, height: 44, alignment: .center)
                        Text("Exporter")
                            .frame(width: 100, height: 44, alignment: .center)
                    }
                }
                //.frame(width: 44, height: 44, alignment: .center)
                
                /*
                .sheet(isPresented: $shareSheetIsPresented) {
                  ShareSheet(
                    activityItems: [datas.toJson() as Any],
                    excludedActivityTypes: [.copyToPasteboard])
                }
                */
                
               
            }
            
                
            VStack {
                //Spacer(minLength: 800)
                // Share Sheet
                Button(action: { self.shareSheetIsPresented = true }) {
                    VStack {
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 44, height: 44, alignment: .center)
                        Text("Export to pdf")
                            .frame(width: 100, height: 44, alignment: .center)
                    }
                }
                //.frame(width: 44, height: 44, alignment: .center)
                /*
                .sheet(isPresented: $shareSheetIsPresented) {
                    ShareSheet(
                    activityItems: [datas.toJson() as Any],
                    excludedActivityTypes: [.copyToPasteboard])
                }
                */
                //exportToPDF()
                
            }
                
          
            }
             // _______________________________
            */
            }
            Spacer()
        
    }
}

struct TensionBarView_Previews: PreviewProvider {
    static var previews: some View {
        //TensionBarView(patient: Personne(), datas: testMesures)
        TensionBarView(patient: Personne())
    }
}


