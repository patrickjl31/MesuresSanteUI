//
//  ContentViewChoix.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 06/03/2022.
//

import SwiftUI

struct ContentViewChoix: View {
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
            
        
        NavigationView{
            
            VStack {
                NavigationLink("Content view 1", destination: ContentView1())
                
                NavigationLink("Content view 2", destination: ContentView2())

            }
            
                
            }
        }
       
}

struct ContentViewChoix_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewChoix()
    }
}
