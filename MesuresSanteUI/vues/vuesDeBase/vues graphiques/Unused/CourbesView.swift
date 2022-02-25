//
//  CourbesView.swift
//  tension
//
//  Created by patrick lanneau on 11/12/2020.
//

import SwiftUI



struct CourbesView: View {
    
    @ObservedObject var patient : Personne
    @ObservedObject var datas : Mesures
    
    //var systoliques : [Mesure] = []
    
    //@State var typeMesureSelected : Int = 0
    //var typeMesures = ["Systolique", "Diastolique", "Les deux"]
    
    var body: some View {
        ZStack {
            
            VStack{
                TitulatureView(titreSpecifique: "Vos mesures en courbes...")
                // Tracé des courbes
                PeriodeView(patient: patient)
                Spacer()
                
                
//                if !datas.noMesures() {
//                    Picker(selection: $typeMesureSelected, label: Text ("Quel type de mesure ?")){
//                        ForEach(0..<typeMesures.count) {
//                            Text(self.typeMesures[$0])
//                        }
//                }
//                }
                
            }
 
            VStack{
                Spacer()
                //PeriodeView(patient: patient, datas: datas)
                
                if !datas.noMesures() {
                    let courbes = datas.courbes()
                    
                    ZStack {
                        TraceCourbe(listePointsX: courbes.systol, couleur: COUL_SYSTO, multi: 30)
                        TraceCourbe(listePointsX: courbes.diastol, couleur: COUL_DIASTO, multi: 30)
                        CarroyageHorizontal1(patient: patient, limB: Int(courbes.mini.rounded(.down)), limH: Int(courbes.maxi.rounded(.up)), multi: Int(30))
                        
                    }
                    
                    //ExtractedView(datas: datas)
                    // Fin scroll view
                  
                    Spacer()
                    HStack(alignment: .center, spacing: 10) {
                        Text("Légende : ")
                            .foregroundColor(.black)
                        //Spacer()
                        Text("Systolique ")
                            .foregroundColor(COUL_SYSTO)
                        
                        Text("Diastolique")
                            .foregroundColor(COUL_DIASTO)
                        //Spacer()
                    }
                    .font(.title3)
                    
                    Spacer()

                }
            
            }
            
        }
        
    }
    
    func traceArray(tablo : [Double]) -> String {
        var rep = ""
        for index in 0..<tablo.count{
            rep += String(tablo[index]) +  " - "
        }
        return rep
    }
}

struct CourbesView_Previews: PreviewProvider {
    static var previews: some View {
        CourbesView(patient: Personne(), datas: testMesures)
    }
}




extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
