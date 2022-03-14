//
//  SaisieTensionView.swift
//  tension (iOS)
//
//  Created by patrick lanneau on 06/12/2020.
//

import SwiftUI

struct SaisieTensionView: View {
    
    @ObservedObject var user : Users
    @ObservedObject var patient : Personne
    //@ObservedObject var datas : Mesures
    
    @State var systolique : Double = 12
    @State var diastolique : Double = 8
    @State var coeur : Double = 70
    @State var oxygene : Double = 98
    //@State var date:Date = Date()
    
    @State var momment : String = "AM"
    
    @State var memsystolique : Double = 0
    @State var memdiastolique : Double = 0
    @State var memcoeur : Double = 0
    @State var memoxygene : Double = 0
    @State var combienMesures: Double = 0
    
    @State var autreJour = false
    @State var releveDu : Date = Date()
    
    @State var pulse:Bool = false
    @State var isModified = false
    
    // Valeurs par défaut
    let defautSystolique : Double = 12
    let defautDiastolique : Double = 8
    let defautCoeur : Double = 70
    let defautOxygene : Double = 98
    
    // MARK: - Fonctions
    /*
    func enregistrer(){
       
        let newTension = Mesure(systolique: memsystolique, distolique: memdiastolique, pulsation: memcoeur, dateMesurS: "", dateMesure: releveDu, moment: "PM")
        //let newDiabete =
        //patient.enregistrerGlycemie(sucre: newGlycemie)
        //patient.diabete.enregistrerMesure(leSucre: taux, date: dateDuReleve)
        user.addMesureTension(tension: newTension)
        patient.saveSucre()
        //
        
    }
    */
    func testConstantes()->String{
        var rep = ""
        if systolique > 16 {
            rep += " Votre tension systooique est trop élevée !\n "
        }
        if diastolique > 12 {
            rep += " Votre tension diastolique est trop élevée !\n "
        }
        if ((systolique - diastolique) < 2) && (systolique > 0) {
            rep += " Ttension pinçée !\n "
        }
        if (oxygene < 95) && (oxygene > 10) {
            rep += " Oxygén&ation insuffisante. Faites un test covid. "
        }
        if rep.count > 0 {
            rep = "Attention !" + rep
        }
        return rep
    }
    
    func laDate(date:Date)->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "FR-fr")
        format.dateFormat = "EEEE dd MMMM yyyy"
        return format.string(from: date)
        
    }
    
    var body: some View {
        //let patient:Personne = user.listeUsers[user.userCourant]
        
            NavigationView {
                //let patient : Personne = user.listeUsers[user.userCourant]
                
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
                            .scaleEffect(pulse ? 1.0 : 0.9)
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
                                .padding(.top, 20)
                           
                            Text("Prenez la 2 ou 3 fois, je ferai la moyenne...")
                                .font(.title3)
                                .fontWeight(.bold)
                            Divider()
                             
                            SaisieDate(releveDu: $releveDu)
                           
                            
                        })
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("BleuNoir"))
                        .padding(.bottom, 20)
                        //Spacer(minLength: 10)
                        Group {
                            VStack {
                                DemandeDouble(titre: "Systolique", valeur: $systolique, isChanged: $isModified, mini: 3, maxi : 26, couleur: COUL_SYSTO)
                                DemandeDouble(titre: "Diastolique", valeur: $diastolique, isChanged: $isModified, mini: 3, maxi : 26, couleur: COUL_DIASTO)
                                DemandeDouble(titre: "Fréquence cardiaque", valeur: $coeur, isChanged: $isModified, mini: 30, maxi : 160, pas: 1, couleur: COUL_COEUR)
                                DemandeDouble(titre: "Oxygène", valeur: $oxygene, isChanged: $isModified, mini: 40, maxi : 100, pas: 1, couleur: COUL_OXY)
                            }
                            .padding(.bottom, 20)
                            //Spacer()
                            
                            if allSliderSelecteds(){
                                let attention = testConstantes()
                                if attention.count > 0 {
                                    Text(attention)
                                        .font(.system(size: 14, weight: .heavy, design: .rounded))
                                        .foregroundColor(Color.white)
                                        .background(Color.red)
                                        .padding(.horizontal, 10)
                                }
                            }
                            HStack{
                                Text("Moyenne :")
                                    .foregroundColor(.black)
                                VStack(alignment: .leading, spacing: 2){
                                    Text("Systolique ->\(memsystolique, specifier: "%.1f")")
                                        .foregroundColor(COUL_SYSTO)
                                        
                                    Text("Diastolique ->\(memdiastolique, specifier: "%.1f")")
                                        .foregroundColor(COUL_DIASTO)
                                    Text("Coeur ->\(memcoeur, specifier: "%.0f")")
                                        .foregroundColor(COUL_COEUR)
                                    Text("Oxygène ->\(memoxygene, specifier: "%.0f")")
                                        .foregroundColor(COUL_OXY)
                                }
                                .font(.system(size: 13, weight: .black, design: .rounded))
                                
                                // Voir en listes
                                Spacer()
                                NavigationLink {
                                    
                                    ListeView(user: user)
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
                            //Spacer()
                           
                        }
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        
                        //allSliderSelecteds()
                        if isModified {
                            Button(action: {
                                combienMesures += 1
                                memsystolique = calculeMoyenne(cumul: memsystolique, nouveau: systolique, mesures: combienMesures)
                                systolique = 0
                                memdiastolique = calculeMoyenne(cumul: memdiastolique, nouveau: diastolique, mesures: combienMesures)
                                diastolique = 0
                                memcoeur = calculeMoyenne(cumul: memcoeur, nouveau: coeur, mesures: combienMesures)
                                coeur = 0
                                memoxygene = calculeMoyenne(cumul: memoxygene, nouveau: oxygene, mesures: combienMesures)
                                oxygene = 0
                                autreJour = false
                                isModified = false
                                
                            }, label: {
                                BlocBouton(texte: "Ajouter cette mesure")
                            })
                        }
                        //Spacer()
                        
                        if (memsystolique > 0) && (memdiastolique > 0) && (memcoeur > 0) {
                            Button(action: {
                                enregistrer()
                                //resetValues()
                            }
                            
                            , label: {
                                BlocBouton(texte: "Enregister cette série de mesures")
                            })
                            
                        }
                        
                        //Spacer()
                        // Voir toutes les mesures
                         
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
                            
                            Courbes1View(patient: patient)
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
                            
                            TensionBarView(patient: user.listeUsers[user.userCourant])
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
            .navigationViewStyle(StackNavigationViewStyle())
        
    }
    // MARK: - Fonctions
    
    func enregistrer(){
        
        let newTension : Mesure = Mesure( systolique: memsystolique, distolique: memdiastolique, pulsation: memcoeur, dateMesure: releveDu, moment: momment)
        user.addMesureTension(tension: newTension)
        test(texte: "systolique : \(memsystolique)")
        resetValues()
        
    }
    func resetValues()  {
        memsystolique = 0
        memdiastolique = 0
        memcoeur = 0
        memoxygene = 0
        combienMesures = 0
        //
        systolique = defautSystolique
        diastolique = defautDiastolique
        coeur = defautCoeur
        oxygene = defautOxygene
    }
    
    func calculeMoyenne(cumul : Double, nouveau : Double, mesures: Double) -> Double {
        return ((cumul * (mesures - 1)) + nouveau) / mesures
    }
    func allSliderSelecteds() -> Bool {
        return (systolique > 4.5) && (diastolique > 3 ) && (coeur > 20) && (oxygene > 40)
    }
    
    func test(texte:String){
        print(" trace saisie tension \(texte)")
    }
   
    
}

struct SaisieTensionView_Previews: PreviewProvider {
    static var previews: some View {
        SaisieTensionView(user: Users(), patient: Personne(), systolique: 14, diastolique: 8, coeur: 60, oxygene: 95)
            .previewDevice(PreviewDevice(rawValue: "iPhone Xr"))
        //SaisieTensionView(patient: Personne(), datas: Mesures(), systolique: 14, diastolique: 8, coeur: 60)
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
    }
}
