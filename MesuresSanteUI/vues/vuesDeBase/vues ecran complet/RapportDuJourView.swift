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
    
    
    @ObservedObject var user : Users
    //@ObservedObject var patient : Personne
    
    //@ObservedObject var datas : Mesures
    
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
        let fiche = RapportQuotidien()
        fiche.selles = selles
        fiche.date = date
        fiche.diurese = diurese
        fiche.douleur = Int(douleur)
        fiche.temperature = temperature
        fiche.etatCutane = etatCutane
        fiche.moral = moral
        fiche.remarques = remarques
        
        user.addMesureRapport(rapport: fiche)
        if indexRapport > -1 {
            user.removeMesureRapport(atIndex: IndexSet([indexRapport]))
            //patient.removeRapport(at: [indexRapport])
        }
        
        //user.currentUser.addRapport(rapport: fiche)
        //let patient = user.getCurrentUser()
        //patient?.addRapport(rapport: fiche)
    }
    
    func nomPatient()->String{
        var nom = ""
        if user.existCurrentUser(){
            nom = user.listeUsers[user.userCourant].nom + " " + user.listeUsers[user.userCourant].prenom
        }
        return nom
    }
    
    
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
                  
                    HStack {
                        Image("logo-sante-2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        DateDuJourView(date: date)
                    }
                    
                    
                    HStack {
                        //var nom = patient.prenom + " " + patient.nom
                        
                        //Text("Bonjour")
                     
                        //Spacer()
                        
                        if nomPatient().count > 0{
                            Text("Bonjour \(nomPatient()) ")
                                .font(.system(size: 18, weight: .heavy, design: .rounded))
                                .foregroundColor(Color("BleuSombre"))
                                //.shadow(color: .black, radius: 4, x: 4, y: 4)
                        } else {
                           // DemandeNom(patient: patient)
                            //    .padding(.vertical, 5)
                        }
                        
                    }
                    .padding()
                    
                    Divider()
                    HStack(alignment: .center) {
                        
                        
                        NavigationLink(destination: {
                            if user.existCurrentUser(){
                                ListeRapportsView(patient: user.listeUsers[user.userCourant], datas: user.listeUsers[user.userCourant].tension)
                            }
                            
                        }, label: {
                            VStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Exporter")
                            }
                        })
                        
                        Spacer()
                        
                        NavigationLink(destination: {
                            //DetailRapportView(patient: patient, rapport: patient.rapportsQuotidien)
                            if user.existCurrentUser(){
                                TousLesRapports(patient: user.listeUsers[user.userCourant])
                            }
                            
                        }, label: {
                            VStack {
                                Image(systemName: "list.bullet.rectangle")
                                Text("Les rapports")
                            }
                        })
                        Spacer()
                        
                        NavigationLink(destination: {
                            if user.existCurrentUser(){
                                TousLesRapports(patient: user.listeUsers[user.userCourant])
                                //ListeRapportsView(patient: patient, datas: patient.tension)
                            }
                            
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
                        
                        BlocSlider(texte: "Température : ", valeur: $temperature, mini: 33.0, maxi: 44.0, pas: 0.1, couleur: .red)
                        BlocSlider(texte: "Douleur (1 à 10 ( l / 24h)", valeur: $douleur, mini: 0.0, maxi: 10.0, pas: 1.0, couleur: .red)
                        BlocSlider(texte: "Diurese ( l / 24h)", valeur: $diurese, mini: 0.0, maxi: 2.0, pas: 0.1, couleur: Color("JauneSombre"))
                        
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
                  
                }
                
                Spacer()
            }//ScrollView
            //.navigationTitle(Text("Rapport quotidien"))
            //.navigationBarTitleDisplayMode(.inline)
            
            //Spacer()
        }//VStack
        .navigationViewStyle(StackNavigationViewStyle())
        //.ignoresSafeArea()
        //.safeAreaInset(edge: .bottom)
    }
        
}


/* */
struct RapportDuJourView_Previews: PreviewProvider {
    static var previews: some View {
        RapportDuJourView(user: Users())
        //RapportDuJourView(user: Users(), patient: Personne())
        //RapportDuJourView()
    }
}
 

