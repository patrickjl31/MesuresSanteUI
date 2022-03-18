//
//  ContentView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 11/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    // Tous les utilisateurs
    @ObservedObject var users: Users = Users()
    
    //@ObservedObject var dataSucre: MesuresSucre = MesuresSucre()
    //@ObservedObject var patient: Personne = Personne()
    //@ObservedObject var datas : Mesures = Mesures()
    
    
    @State private var selectPage = 0 //0
    
    @State var existCurrentPatient = false
    
    
    var body: some View {
        // Les objets de base
        //var patient
        //var datas : Mesures = patient.tension
        //var patient: Personne = users.
        //var
        
        //MAEK: -
        //VStack {
            
            TabView(selection: $selectPage) {
                //Text("Tab Content 1").tabItem
               
                
                AccueilPatients(users: users).tabItem
                {
                    //Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    Image(systemName: "person.3.sequence")
                        .frame(width: 50, height: 50, alignment: .center)
                    Text("Patients") }
                    
                    .tag(0)
                
                // MARK: - Les acces au patient courant
                //-----------------------------------
                
                /* */
                //---- les icones du bas
                if users.existCurrentUser() {
                    let patient = users.listeUsers[users.userCourant]
                    RapportDuJourView(user: users, patient: patient).tabItem
                    {
                        //Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .frame(width: 50, height: 50, alignment: .center)
                        Text("Rapport") }
                    .tag(1)
                     
                    
                    //SaisieTensionView(user: users, patient: patient, systolique: 0, diastolique: 0, coeur: 0).tabItem
                    SaisieTensionView1(user: users, systolique: 0, diastolique: 0, coeur: 0, oxygene: 0)
                        .tabItem
                        {
                            Image(systemName: "bolt.heart")
                                .frame(width: 50, height: 50, alignment: .center)
                            Text("Tension") }
                    .tag(2)
                    /*
                    SaisieTensionView(patient: patient, datas: patient.tension, systolique: 0, diastolique: 0, coeur: 0).tabItem
                        {
                            Image(systemName: "bolt.heart")
                                .frame(width: 50, height: 50, alignment: .center)
                            Text("Tension") }
                    .tag(2)
                     */
                    SaisieSucreView(user: users).tabItem
                        {
                            Image(systemName: "pills")
                                .frame(width: 50, height: 50, alignment: .center)
                            Text("Glycémie") }
                        .tag(3)
                      
                }
                
              
               
                /**/
                #if TARGET_OS_IPHONE
                
                    HelpView().tabItem
                    {
                    Image(systemName: "info.circle")
                        .frame(width: 50, height: 50, alignment: .center)
                    Text("Info") }
                    
                    .tag(4)
                #else
                
                    MacHelp().tabItem
                    {
                    Image(systemName: "info.circle")
                        .frame(width: 50, height: 50, alignment: .center)
                    Text("Info") }
                    
                    .tag(5)
                #endif
                
                
                //Spacer()
                // Bouton enregistrer
                
                // Bouton PDF
            
            }
            .frame(minWidth: windowSize().minWidth,  maxWidth: .infinity, minHeight: windowSize().minHeight, idealHeight: .infinity, maxHeight: .infinity)
        //}VStack
        
        
        #if TARGET_OS_IPHONE
        //
        #else
        //
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct windowSize {
let minWidth : CGFloat = 300
let minHeight : CGFloat = 800
let maxWidth : CGFloat = 1200
let maxHeight : CGFloat = 1200
}



/*
 eyedropper
 eyedropper.halffull
 heart.text.square
 bolt.heart
 pencil
 pills
 
 */
