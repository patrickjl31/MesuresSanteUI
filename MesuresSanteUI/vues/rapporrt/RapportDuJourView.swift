//
//  RapportDuJourView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 14/02/2022.
//
//permet d'aller sur la liste des rapports
//et de là revenir sur un rapport particulier
//
//

import SwiftUI

struct RapportDuJourView: View {
    
    // MARK: - Propriétéss
    @ObservedObject var patient : Personne
    
    @ObservedObject var datas : Mesures
    
    var indexRapport :Int = -1
    
    var date : Date = Date()
    @State var nom:String = ""
    
    
    @State var selles :Int = 0
    @State var diurese : Double = 1.0
    @State var douleur : Double = 0.0
    @State var temperature : Double = 37.0
    @State var etatCutane : String = ""
    @State var moral : String = ""
    @State var remarques : String = ""
    
    
    
    // MARK: - Fonctions
    func laDate(date:Date)->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "FR-fr")
        format.dateFormat = "EEEE dd MMMM yyyy"
        return format.string(from: date)
        
    }
    
    func enregistrer(){
        var fiche = RapportQuotidien()
        fiche.selles = selles
        fiche.date = date
        fiche.diurese = diurese
        fiche.douleur = Int(douleur)
        fiche.temperature = temperature
        fiche.etatCutane = etatCutane
        fiche.moral = moral
        fiche.remarques = remarques
        
        if indexRapport > -1 {
            patient.removeRapport(at: [indexRapport])
        }
        
        patient.addRapport(rapport: fiche)
    }
    
    /*
    func updateValues(){
        if indexRapport > -1 {
            selles =  patient.rapportsQuotidien[indexRapport].selles
            diurese =  patient.rapportsQuotidien[indexRapport].diurese
            douleur =  Double(patient.rapportsQuotidien[indexRapport].douleur)
            temperature =  patient.rapportsQuotidien[indexRapport].temperature
            etatCutane =  patient.rapportsQuotidien[indexRapport].etatCutane
            moral =  patient.rapportsQuotidien[indexRapport].moral
            remarques =  patient.rapportsQuotidien[indexRapport].remarques
        }
        
    }
    */
    
    
    // MARK: - Corps
   /*
    
    init() {
           // UITextView.appearance().backgroundColor = .yellow
        //updateValues()
        
    }
    
    */


    var body: some View {
        

        
        NavigationView {
            ScrollView {
                
                VStack{
                  
                    DateDuJourView(date: date)
                    
                    HStack {
                        var nom = patient.prenom + " " + patient.nom
                        //Text("Bonjour")
                        
                        Button {
                            patient.effaceIdentite()
                            nom = ""
                            } label: {
                            VStack( spacing: 0){
                                Image(systemName: "highlighter")
                                Text("Edit")
                                    .font(.system(size: 12, weight: .light))
                                }
                            }
                        
                        //Spacer()
                        
                        if patient.nom.count > 0{
                            Text("Bonjour \(patient.prenom) \(patient.nom)")
                                .font(.system(size: 18, weight: .heavy, design: .rounded))
                                .foregroundColor(Color("BleuSombre"))
                                //.shadow(color: .black, radius: 4, x: 4, y: 4)
                        } else {
                            DemandeNom(patient: patient)
                                .padding(.vertical, 5)
                        }
                        
                        

                    }
                    .padding()
                    
                    Divider()
                    HStack(alignment: .center) {
                        
                        
                        NavigationLink(destination: {
                            ListeRapportsView(patient: patient, datas: datas)
                        }, label: {
                            VStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Exporter")
                            }
                        })
                        
                        Spacer()
                        
                        
                        NavigationLink(destination: {
                            ListeRapportsView(patient: patient, datas: datas)
                        }, label: {
                            VStack {
                                Image(systemName: "list.bullet.rectangle")
                                Text("Autres rapports")
                            }
                        })
                    }
                    .padding(.horizontal, 10)
                    
                    Text("Vos relevés du jour...")
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundColor(Color("BleuSombre"))
                        .shadow(color: Color("BlackLigth"), radius: 8, x: 4, y: 4)
                    .padding()
                    
                    
                    
                    
                    Group {
                        
                        BlocSlider(texte: "Température : ", valeur: $temperature, mini: 30.0, maxi: 45.0, pas: 0.1, couleur: .red)
                        BlocSlider(texte: "Douleur (1 à 10 ( l / 24h)", valeur: $douleur, mini: 0.0, maxi: 10.0, pas: 1.0, couleur: .red)
                        BlocSlider(texte: "Diurese ( l / 24h)", valeur: $diurese, mini: 0.0, maxi: 3.0, pas: 0.1, couleur: Color("JauneSombre"))
                        
                        BlocStepper(texte: "Selles : ", maxi: 15, valeur: $selles, couleur: .brown)
                        BlocTextfield(reponse: $etatCutane, message: "Etat cutané : ", couleur: Color("BleuSombre"))
                        BlocTextfield(reponse: $moral, message: "Etat moral : ", couleur: Color("BleuSombre"))
                        //BlocTextfield(reponse: $remarques, message: "Remarques : ", couleur: Color("BleuSombre"))
                        Text("Remarques")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color("BleuSombre"))
                        TextEditorView(remarques: $remarques)
                            .frame(width: 350, height: 70)
                    }//group relevés du jour
                    
                    Divider()
                    Button {
                        enregistrer()
                        //var rapport : RapportQuotidien = RapportQuotidien()
                       // rapport.selles = selles
                        //patient.rapportQuotidien.append(rapport)
                       // patient.addRapport(rapport: rapport)
                        //selles = 0
                    } label: {
                        BlocBouton(texte: "Enregistrer pour ce jour")
                    }
                    Divider()
                    // La liste des mesures
                    /*Text("rapports :")
                    NavigationLink(destination: {
                        ListeRapportsView()
                    }, label: {
                        Text("Liste des rapports")
                    })
                    
                    List (patient.rapportsQuotidien){
                        rapport in
                            ElemListePatient(rapport: rapport, ligne: "aze")
                        }
                    */
                }
                
                Spacer()
            }//ScrollView
            //.navigationTitle(Text("Rapport quotidien"))
            //.navigationBarTitleDisplayMode(.inline)
            
            //Spacer()
        }//VStack
        //.ignoresSafeArea()
        //.safeAreaInset(edge: .bottom)
    }
        
}


/* */
struct RapportDuJourView_Previews: PreviewProvider {
    static var previews: some View {
        RapportDuJourView(patient: Personne(), datas: Mesures())
        //RapportDuJourView()
    }
}
 

