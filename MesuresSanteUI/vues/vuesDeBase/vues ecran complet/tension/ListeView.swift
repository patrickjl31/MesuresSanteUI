//
//  ListeView.swift
//  tension
//
//  Created by patrick lanneau on 10/12/2020.
//

import SwiftUI

struct ListeView: View {
    
    // MARK: - Propriéeés
    @ObservedObject var user : Users
    //@ObservedObject var patient : Personne
    //@ObservedObject var datas : Mesures
    
    @State var showAlert = false
    @State var pulse = false
    
    // MARK: - Fonctions
    
    func removeRows(at offsets: IndexSet) {
        //patient.rapportsQuotidien.remove(atOffsets: offsets)
        //patient.removeRapport(at: offsets)
        //user.removeMesureSucre(atIndex: offsets)
        user.removeMesureTension(atIndex: offsets)
    }
    
    
    //Exporter avec airdrop
    func airportActionSheet(texte:String = "désolé") {
        //guard let data = URL(string: "https://www.zoho.com") else { return }
        let data = texte
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(content: {
                Image("coeur2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.6)
                    .frame(width: 350, height: 100, alignment: .center)
                Spacer()
                Image("coeur1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    .scaleEffect(pulse ? 1.1 : 1)
                    .opacity(0.8)
                    //.animation(.easeInOut(duration: 1).repeatForever(autoreverses: true) )
                Spacer()
            })
            
            
            VStack {
                VStack(alignment: .center) {
                    Text("Vos mesures de tension...")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("BleuNoir"))
                    Text("Vous pouvez supprimer les mesures erronnées...")
                        .font(.title2)
                        .foregroundColor(Color("BleuNoir"))
                    List {
                        //datas.maTension
                        let mesure = user.listeUsers[user.userCourant].tension.maTension
                        ForEach((0..<mesure.count), id:\.self){index in
                            VStack(alignment: .leading) {
                                let ligne2 = "Mesure du : \(mesure[index].dateMesure.toShortString())/ \(mesure[index].moment)"
                                let ligne1 =  String(format: " Syst :  %.1f", mesure[index].systolique) + " " + String(format: " Dyst :  %.1f", mesure[index].distolique) + " " + String(format: " Coeur :  %.0f", mesure[index].pulsation)  + " " + String(format: " Oxygène :  %.0f", mesure[index].oxygene)
                                
                                ElemListeCardio(ligne1: ligne1, ligne2: ligne2)
                                /*
                                    .onTapGesture {
                                        user.removeMesureTension(atIndex: IndexSet([index]))
                                    }
                                 */
                            }
                        }
                        /**/
                        .onDelete(perform: { indexSet in
                            removeRows(at: indexSet)
                        })
                         
                    }
                    
                    
                }
                .multilineTextAlignment(.center)
                .opacity(0.8)
                
                
                HStack {
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
                            print("Effacement total")
                            // user.deleteAllTension()
                            //datas.deleteAll()
                        }, secondaryButton: .cancel())
                })
                    
                    Button(action: {
                        //datas.deleteAll()
                        airportActionSheet(texte: user.listeUsers[user.userCourant].toAirdrop(mesuresDe: TENSIONS))
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                        Text("Exporter")
                    })
                    
                
                } // : HStack
            
            }
            
            
        }
        .onAppear(){
            //pulse.toggle()
            withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true) ) {
                pulse = true
            }
        }

        
    }
}

struct ListeView_Previews: PreviewProvider {
    static var previews: some View {
        ListeView(user: Users())
            
    }
}

