//
//  SaisieTensionView.swift
//  tension (iOS)
//
//  Created by patrick lanneau on 06/12/2020.
//

import SwiftUI

struct SaisieTensionView: View {
    @ObservedObject var patient : Personne
    @ObservedObject var datas : Mesures
    
    @State var systolique : Double
    @State var diastolique : Double
    @State var coeur : Double
    
    @State var memsystolique : Double = 0
    @State var memdiastolique : Double = 0
    @State var memcoeur : Double = 0
    @State var combienMesures: Double = 0
    
    @State var autreJour = false
    @State var releveDu : Date = Date()
    
    @State var pulse:Bool = false
    
    // MARK: - Fonctions
    func laDate(date:Date)->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "FR-fr")
        format.dateFormat = "EEEE dd MMMM yyyy"
        return format.string(from: date)
        
    }
    
    var body: some View {
        
            NavigationView {
                
                
                ZStack {
                    let animation = Animation
                        .linear(duration: 1.0)
                        .repeatForever(autoreverses: false)

                    FondEcranView()
                        .opacity(pulse ? 0.4 : 0.1)
                        .scaleEffect(pulse ? 1.1 : 0.8)
                        .onAppear(){
                            DispatchQueue.main.async {
                                // << postpone till end of views construction !!
                                    //pulse = true
                                withAnimation(animation) {
                                        pulse = true
                                }
                            }
                                //pulse.toggle()
                        }
                   
                    VStack {
                                
                        //Spacer()
                    }
                    
                    ScrollView( showsIndicators: true) {

                    VStack{
                        
                        EnTeteTension()
                            .scaleEffect(pulse ? 1.1 : 0.8)
                            .onAppear(){
                                DispatchQueue.main.async {
                            // << postpone till end of views construction !!
                            //pulse = true
                            withAnimation(animation) {
                                pulse = true
                            }
                            }
                            //pulse.toggle()
                        }
                       
                        
                        
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
                            Text("Prenez votre tension matin et soir...")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                           
                            Text("Prenez la 2 ou 3 fois, je ferai la moyenne...")
                                .font(.title3)
                                .fontWeight(.bold)
                            Divider()
                             
                            SaisieDate(releveDu: $releveDu)
                            /*
                            Group {
                                Toggle("Saisir le relevé d'un autre jour ?", isOn: $autreJour)
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                    .tint(.blue)
                                    
                                if autreJour {
                                    DatePicker(selection: $releveDu,
                                        label: { Text("Relevés du :") })
                                                    }
                                else {
                                    Text("Mesures réalisées le \(releveDu.identDateAndMoment().date) (\(releveDu.identDateAndMoment().moment))")
                                    
                                }
                            }
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            */
                            
                        })
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("BleuNoir"))
                        
                        Spacer()
                        Group {
                            VStack {
                                DemandeDouble(titre: "Systolique", valeur: $systolique, mini: 3, maxi : 26, couleur: COUL_SYSTO)
                                DemandeDouble(titre: "Diastolique", valeur: $diastolique, mini: 3, maxi : 26, couleur: COUL_DIASTO)
                                DemandeDouble(titre: "Fréquence cardiaque", valeur: $coeur, mini: 20, maxi : 160, pas: 1, couleur: Color.green)
                            }
                            Spacer()
                            
                            /*
                            Text("Moyenne : Systolique ->\(memsystolique, specifier: "%.1f"), Diastolique ->\(memdiastolique, specifier: "%.1f"), Coeur ->\(memcoeur, specifier: "%.0f")")
                                //.font(.headline)
                                .foregroundColor(.blue)
                                .multilineTextAlignment(.center)
                            */
                            
                            if systolique > 16 {
                                Text(" Attention votre tension systooique est trop élevée ! ")
                                    .font(.system(size: 12, weight: .heavy, design: .rounded))
                                    .foregroundColor(Color.white)
                                    .background(Color.red)
                                    .padding(.horizontal, 10)
                            }
                            if diastolique > 12 {
                                Text(" Attention votre tension diastolique est trop élevée ! ")
                                    .font(.system(size: 12, weight: .heavy, design: .rounded))
                                    .foregroundColor(Color.white)
                                    .background(Color.red)
                                    .padding(.horizontal, 10)
                            }
                            if ((systolique - diastolique) < 3) && (systolique > 0) {
                                Text(" Attention tension pinçée ! ")
                                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                                    .foregroundColor(Color.white)
                                    .background(Color.red)
                                    .padding(.horizontal, 10)
                            }
                            
                            
                            HStack{
                                Text("Moyenne :")
                                    .foregroundColor(.black)
                                    .font(.system(size: 18, weight:.bold, design: .rounded))
                                VStack(alignment: .leading, spacing: 5){
                                    Text("Systolique ->\(memsystolique, specifier: "%.1f")")
                                        //.font(.headline)
                                        .foregroundColor(.red)
                                    Text("Diastolique ->\(memdiastolique, specifier: "%.1f")")
                                        //.font(.headline)
                                        .foregroundColor(.blue)
                                    Text("Coeur ->\(memcoeur, specifier: "%.0f")")
                                        //.font(.headline)
                                        .foregroundColor(.green)
                                }
                                
                                // Voir en listes
                                Spacer()
                                NavigationLink {
                                    
                                    ListeView(patient: patient, datas: datas)
                                    // test de sortie
                                    
                                    
                                    
                                } label: {
                                    VStack{
                                        
                                        Image(systemName: "list.bullet")
                                        Text("Toutes les mesures")
                                            .fixedSize(horizontal: false, vertical: true)
                                            .lineLimit(2)
                                    }
                                    .font(.system(size: 18, weight: .light, design: .rounded))
                                }
                                
                                
                            }
                            Spacer()
                           
                        }
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        
                        if allSliderSelecteds() {
                            Button(action: {
                                combienMesures += 1
                                memsystolique = calculeMoyenne(cumul: memsystolique, nouveau: systolique, mesures: combienMesures)
                                systolique = 0
                                memdiastolique = calculeMoyenne(cumul: memdiastolique, nouveau: diastolique, mesures: combienMesures)
                                diastolique = 0
                                memcoeur = calculeMoyenne(cumul: memcoeur, nouveau: coeur, mesures: combienMesures)
                                coeur = 0
                                
                                autreJour = false
                                /*
                                if let t = datas.toJson(){
                                    test(texte: t)
                                }
                                */
                            }, label: {
                                BlocBouton(texte: "Ajouter cette mesure")
                            })
                        }
                        Spacer()
                        
                        
                        if (memsystolique > 0) && (memdiastolique > 0) && (memcoeur > 0) {
                            Button(action: {
                                datas.enregistrerMesure(syst: memsystolique, diast: memdiastolique, coeur: memcoeur, date: releveDu)
                                resetValues()
                            }
                            
                            , label: {
                                BlocBouton(texte: "Enregister cette série de mesures")
                            })
                            
                            
                        }
                        
                        //Spacer()
                        // Voir toutes les mesures
                        
                        
                        /*
                        NavigationLink {
                            ListeView(patient: patient, datas: datas)
                        } label: {
                            HStack{
                                Image(systemName: "list.bullet.rectangle")
                                    .font(.system(size: 14, weight: .light, design: .rounded))
                                Text("Toutes les mesures")
                            }
                        }

                         */
                         
                        Spacer()
                    }
                    .frame(minWidth: windowSize().minWidth,  maxWidth: 1000, minHeight: windowSize().minHeight, idealHeight: 1200, maxHeight: 1400)
                    //.background(Color.clear)
                    //Color.clear
                    .padding(.horizontal, 20)
                    
                    
                    
                }
                
                      
                //------------------
                // lzs boutons de la toolbar
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink {
                            //ListeView(patient: patient, datas: datas)
                            Courbes1View(patient: patient, datas: datas)
                        } label: {
                            VStack{
                                //Image(systemName: "waveform.path.ecg.rectangle")
                                Image(systemName: "chart.xyaxis.line")
                                Text("Courbes")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(2)
                            }
                            .font(.system(size: 18, weight: .light, design: .rounded))
                        }
                    }
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            //ListeView(patient: patient, datas: datas)
                            //Courbes1View(patient: patient, datas: datas)
                            TensionBarView(patient: patient, datas: datas)
                        } label: {
                            VStack{
                                Image(systemName: "chart.bar.xaxis")
                                //Image(systemName: "chart.xyaxis.line")
                                Text("Histagrammes")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(2)
                            }
                            .font(.system(size: 18, weight: .light, design: .rounded))
                        }
                    }
                    
                    
                }
                
                }//Scrollview
                .navigationTitle("Votre tension")
                .navigationBarTitleDisplayMode(.inline)
            }// NavigationView
       
        
    }
    
    func resetValues()  {
        memsystolique = 0
        memdiastolique = 0
        memcoeur = 0
        combienMesures = 0
    }
    
    func calculeMoyenne(cumul : Double, nouveau : Double, mesures: Double) -> Double {
        return ((cumul * (mesures - 1)) + nouveau) / mesures
    }
    func allSliderSelecteds() -> Bool {
        return (systolique > 0) && (diastolique > 0 ) && (coeur > 0)
    }
    
    func test(texte:String){
        print(texte)
    }
   
    
}

struct SaisieTensionView_Previews: PreviewProvider {
    static var previews: some View {
        SaisieTensionView(patient: Personne(), datas: Mesures(), systolique: 14, diastolique: 8, coeur: 60)
            .previewDevice(PreviewDevice(rawValue: "iPhone Xr"))
        SaisieTensionView(patient: Personne(), datas: Mesures(), systolique: 14, diastolique: 8, coeur: 60)
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
    }
}
