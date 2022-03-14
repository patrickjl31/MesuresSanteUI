//
//  ResultatsView.swift
//  tension
//
//  Created by patrick lanneau on 09/12/2020.
//

import SwiftUI

struct ResultatsView: View {
    
    @ObservedObject var patient : Personne
    @ObservedObject var datas : Mesures
    
    @State var shareSheetIsPresented = false
    
    var body: some View {
        ZStack {
            
            VStack {
                TitulatureView(titreSpecifique: "Vos résultats en histogrammes...")
                Spacer()
            
                PeriodeView(patient: patient)
            if !datas.noMesures() {
                // On affiche les barres
                //Text("Systolique ")
                
                Spacer()
                //ExtractedView(datas: datas)
                ExtractedVievBar(datas: patient.tension, epaisseur: 40, coefHauteur: 25)
                // Fin scroll view
            }
            
            /*
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
            */
            }
            Spacer()
        }
    }
    // placer ici les fonctions internes à la struct
    func exportToPDF() {
        let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("SwiftUI.pdf")
        let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let rootVC = UIApplication.shared.windows.first?.rootViewController

        //Render the PDF
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
        DispatchQueue.main.async {
            do {
                try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                    context.beginPage()
                    rootVC?.view.layer.render(in: context.cgContext)
                })
                print("wrote file to: \(outputFileURL.path)")
            } catch {
                print("Could not create PDF file: \(error.localizedDescription)")
            }
        }
    }

}

struct ResultatsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultatsView(patient: Personne(), datas: testMesures)
    }
}









struct ExtractedView: View {
    
    @ObservedObject var datas : Mesures
    
    var body: some View {
        ScrollView(.horizontal) {
            //Spacer(50)
            
            HStack(alignment: .bottom, spacing: 2, content: {
                ForEach(datas.maTension, id:\.dateMesure){mesure in
                    //Text("Systolique = \(mesure.systolique)")
                    ZStack(alignment: .bottom, content: {
                        
                        // Les barres
                        
                        VStack {
                            HStack(alignment: .bottom) {
                                
                                Rectangle()
                                    .fill(COUL_SYSTO)
                                    .opacity((mesure.moment == "PM") ? 0.4 : 1)
                                    .frame(width: 25, height: CGFloat(mesure.systolique) * 20)
                                
                                
                                Spacer(minLength: 0)
                                
                                
                                Rectangle()
                                    .fill(COUL_DIASTO)
                                    .opacity((mesure.moment == "PM") ? 0.4 : 1)
                                    .frame(width: 20, height: CGFloat(mesure.distolique) * 20)
                                
                                //Spacer(minLength: 3)
                                
                            }
                            // la date
                            let quand = mesure.dateMesure.identDateAndMoment()
                            Text("\(quand.date) / \(quand.moment)")
                                //.font(.footnote)
                                .font(Font.system(size: 8))
                                .rotationEffect(.degrees(-45))
                                .frame(width: 40, height: 50
                                       , alignment: .leading)
                            //.offset(x: 0.0, y: 10)
                            
                        }
                        
                        
                        
                        // Le texte
                        HStack {
                            //Spacer()
                            Text("Syst : \(mesure.systolique, specifier: "%.1f"), Dist: \(mesure.distolique, specifier: "%.1f")")
                                .font(.headline)
                                .background(Color.yellow)
                                .rotationEffect(.degrees(-90))
                                .fixedSize()
                                .frame(width: 40, height: 200, alignment: .center)
                                .offset(y: -50)
                            
                            Spacer()
                        }
                        
                        
                        
                        
                        
                    })
                    
                }
                //Spacer(minLength: 5)
            })
            
            
        }
    }
}
