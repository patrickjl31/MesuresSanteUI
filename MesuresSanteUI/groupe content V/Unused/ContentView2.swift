//
//  ContentView2.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 05/03/2022.
//

import SwiftUI

struct ContentView2: View {
    
    @ObservedObject var users : Identites = Identites()
    
    @State private var selectPage = 0 //0
    
    @State var existCurrentPatient = false
    
    var body: some View {
        //DemandeNomSimple( patients: users, nom: "", prenom: "")
        
        
        TabView(selection: $selectPage) {
            //Text("Tab Content 1").tabItem
           
            
            AccueilPatient1(users: users).tabItem
            {
                //Image(systemName: "rectangle.and.pencil.and.ellipsis")
                Image(systemName: "person.3.sequence")
                    .frame(width: 50, height: 50, alignment: .center)
                Text("Patients") }
                
                .tag(0)
            
            // MARK: - Les acces au patient courant
            //-----------------------------------
            
            /*
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
                    
                SaisieTensionView(patient: patient, datas: patient.tension, systolique: 0, diastolique: 0, coeur: 0).tabItem
                    {
                        Image(systemName: "bolt.heart")
                            .frame(width: 50, height: 50, alignment: .center)
                        Text("Tension") }
                .tag(2)
                            
                SaisieSucreView(patient: patient).tabItem
                    {
                        Image(systemName: "pills")
                            .frame(width: 50, height: 50, alignment: .center)
                        Text("Glycémie") }
                    .tag(3)
                  
            }
            
          
           
            */
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

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
