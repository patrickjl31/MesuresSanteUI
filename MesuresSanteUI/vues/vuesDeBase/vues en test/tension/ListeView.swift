//
//  ListeView.swift
//  tension
//
//  Created by patrick lanneau on 10/12/2020.
//

import SwiftUI

struct ListeView: View {
    
    @ObservedObject var patient : Personne
    @ObservedObject var datas : Mesures
    
    @State var showAlert = false
    @State var pulse = false
    var body: some View {
        ZStack {
            VStack(content: {
                Image("coeur2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 100, alignment: .center)
                Spacer()
                Image("coeur1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    .scaleEffect(pulse ? 1.1 : 1)
                    .opacity(0.8)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true) )
                Spacer()
            })
            
            
            VStack {
                VStack(alignment: .center) {
                    Text("Liste des mesures pour correction...")
                        .font(.title)
                        .foregroundColor(Color("BleuNoir"))
                    Text("Vous pouvez supprimer les mesures erronnées...")
                        .font(.title2)
                        .foregroundColor(Color("BleuNoir"))
                    List {
                        ForEach(datas.maTension, id:\.dateMesure){mesure in
                            VStack(alignment: .leading) {
                                let ligne2 = "\(mesure.dateMesure.toShortString())/ \(mesure.moment)"
                                let ligne1 =  String(format: " Syst :  %.1f", mesure.systolique) + " " + String(format: " Dyst :  %.1f", mesure.distolique) + " " + String(format: " Coeur :  %.0f", mesure.pulsation)
                                ElemListeCardio(ligne1: ligne1, ligne2: ligne2)
                                /*
                                Text(ligne1)
                                    .font(.headline)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                Text(ligne2)
                                    .foregroundColor(.red)
                                    .font(.subheadline)
                                 */
                            }
                            
                            
                        }
                        .onDelete(perform: { indexSet in
                            datas.delete(item: indexSet)
                            
                        })
                    }
                    
                    
                }
                .multilineTextAlignment(.center)
                .opacity(0.8)
                
                
                Button(action: {
                    //datas.deleteAll()
                    self.showAlert = true
                }, label: {
                    Image(systemName: "clear")
                        .font(.title)
                    Text("Tout supprimer")
                })
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Attention !"), message: Text("Voulez-vous réellement effacer les enregistrements ?"), primaryButton: .destructive(Text("Effacer")){
                        //print("Effacement")
                        datas.deleteAll()
                    }, secondaryButton: .cancel())
                })
            
            }
            
            
        }
        .onAppear(){
            pulse.toggle()
        }

        
    }
}

struct ListeView_Previews: PreviewProvider {
    static var previews: some View {
        ListeView(patient: Personne(), datas: Mesures())
            
    }
}


/*
 
 .alert(isPresented: $showAlert, content: {
     Alert(title: "Attention !", message: Text("Voulez-vous réellement effacer les enregistrements ?"), primaryButton: .destructive("Effacer"){
         print("Effacement")
     }, secondaryButton: .cancel())
 })
 
 */
