//
//  ContentView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 11/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    
    //@ObservedObject var dataSucre: MesuresSucre = MesuresSucre()
    @ObservedObject var patient: Personne = Personne()
    //@ObservedObject var datas : Mesures = Mesures()
    
    
    @State private var selectPage = 4 //0
    
    var body: some View {
        var datas : Mesures = patient.tension
        
        TabView(selection: $selectPage) {
            //Text("Tab Content 1").tabItem
            
            RapportDuJourView(patient: patient, datas: patient.tension).tabItem
            {
                //Image(systemName: "rectangle.and.pencil.and.ellipsis")
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    .frame(width: 50, height: 50, alignment: .center)
                Text("Rapport") }
                
                .tag(0)
            
            SaisieTensionView(patient: patient, datas: datas, systolique: 0, diastolique: 0, coeur: 0).tabItem
            {
                //Image(systemName: "rectangle.and.pencil.and.ellipsis")
                Image(systemName: "bolt.heart")
                    .frame(width: 50, height: 50, alignment: .center)
                Text("Tension") }
                
                .tag(1)
            
            SaisieSucreView(patient: patient, datas: datas).tabItem
            {
                //Image(systemName: "rectangle.and.pencil.and.ellipsis")
                Image(systemName: "pills")
                    .frame(width: 50, height: 50, alignment: .center)
                Text("Glycémie") }
                
                .tag(2)
            
            
           /*
            //Text("Tab Content 2")
            if !datas.noMesures(){
                ResultatsView(datas: datas)
                    .tabItem
             {
                Image(systemName: "chart.bar")
                Text("Résultats globaux") }
                .tag(1)
            }
            if !datas.noMesures(){
                CourbesView(datas: datas)
                    .tabItem
             {
                Image(systemName: "waveform.path.ecg.rectangle")
                Text("Résultats courbes") }
                .tag(2)
            }
            
            
            if !datas.noMesures(){
                // supprimer
                ListeView(datas: datas)
                    .tabItem
             {
                Image(systemName: "list.star")
                Text("Supprimer des mesures") }
                .tag(3)
              //enregistrer
                
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
