//
//  SaisieSucreView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 12/02/2022.
//

import SwiftUI

struct SaisieSucreView: View {
    @ObservedObject var user : Users
    
    @ObservedObject var patient : Personne
    //@ObservedObject var datas : Mesures
    
    
    // MARK: - Propriétés
    
    @State var tauxSucreG : Double = 0
    @State var tauxSucreMmol : Double = 0
    @State var taux:Double = 1
    @State var dateDuReleve : Date = Date()
    @State var pulse:Bool = false
    
    // MARK: - Fonctions
    func laDate(date:Date)->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "FR-fr")
        format.dateFormat = "EEEE dd MMMM yyyy"
        return format.string(from: date)
        
    }
    
    func enregistrer(){
        //let newGlycemie = Glycemie(jour: dateDuReleve, duSucre: taux)
        //newGlycemie.sucre = taux
        //newGlycemie.date = dateDuReleve
        
        let newDiabete = MesureSucre(taux: taux, dateMesureS: "", dateMesure: dateDuReleve, moment: "")
        //let newDiabete =
        //patient.enregistrerGlycemie(sucre: newGlycemie)
        //patient.diabete.enregistrerMesure(leSucre: taux, date: dateDuReleve)
        user.addMesureSucre(sucre: newDiabete)
        //patient.saveSucre()
        //
        
    }
    // MARK: - Body
    // 1g = 14,5 mmol
    var body: some View {
        
        
        NavigationView {
        ZStack {
            FondEcranSucreView()
            
            VStack{
                   
                let animation = Animation
                    .linear(duration: 1.0)
                    .repeatForever(autoreverses: false)

                EnTeteSucre()
                    .padding(.vertical, 10)
                                /* */
                    .scaleEffect(pulse ? 1.1 : 0.8)
                        //.animation(.easeIn(duration: 1).repeatForever(autoreverses: true) )
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
                   
                    //DateDuJourView()
                        //.padding(.vertical, 10)
                    //Spacer()
                SaisieDate(releveDu: $dateDuReleve)
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .foregroundColor(Color("BleuSombre"))
                    .shadow(color: Color("BlackLigth"), radius: 3, x: 0, y: 4)
                    .padding(.vertical, 30)
                DoubleSliderView(valeur: $taux, titre1: "Taux en Grammes / litre", titre2: "Taux en mmol / litre", mini1: 0.01, maxi1: 6, mini2: 0.1, maxi2: 120, pas: 0.01, precision: 2, couleur1: .blue, couleur2: .red)
                    
                    if taux > 1.7 {
                        Text("Attention vous êtes en danger !")
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .foregroundColor(.red)
                    }
                    if taux < 0.3 {
                        Text("Attention vous êtes en hypoglycémie !")
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .foregroundColor(.red)
                    }
                    
                    Button {
                        enregistrer()
                    } label: {
                        BlocBouton(texte: "Enregister cette mesure")
                    }
                    .padding(.vertical , 30)
                
    //---------------------------------
                /*
                
                HStack {
                    NavigationLink {
                        //ListeView(patient: patient, datas: datas)
                        //LargeGraphicSucre(patient: patient, datas: patient.diabete, hauteur: 40)
                        CourbeSucreView(patient: patient)
                    } label: {
                        VStack{
                            Image(systemName: "waveform.path.ecg.rectangle")
                            Text("Graphiques")
                        }
                        
                }
                Spacer()
                NavigationLink {
                    //ListeSucreView(patient: patient, datas: datas)
                    ListeSucreView(patient: patient)
                    } label: {
                        VStack{
                            Image(systemName: "list.bullet.rectangle")
                            Text("Tous les \nenregistrements")
                        }
                        
                    }
                }//HStack
                 

                    Spacer()

                }// VStack
                .font(.system(size: 18, weight: .bold, design: .rounded))
            .padding(.horizontal, 10.0)
            
            */
            //-----------------------------------------
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        let patient = user.listeUsers[user.userCourant]
                        CourbeSucreView(patient: patient)
                        //ListeSucreView(user: user, patient: patient)
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
                        ListeSucreView(user: user, patient: patient)
                    } label: {
                        VStack{
                            Image(systemName: "list.bullet.rectangle")
                            Text("Tous les \nenregistrements")
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                        }
                        .font(.system(size: 18, weight: .light, design: .rounded))
                    }
                }
                
                
            }
            
        }
        }//Navigation view
        .navigationViewStyle(StackNavigationViewStyle())
        .padding(.horizontal, 10.0)
        
        }
    }
}

struct SaisieSucreView_Previews: PreviewProvider {
    static var previews: some View {
        //SaisieSucreView(patient: Personne(), datas: Mesures())
        SaisieSucreView(user: Users(), patient: Personne())
    }
}
