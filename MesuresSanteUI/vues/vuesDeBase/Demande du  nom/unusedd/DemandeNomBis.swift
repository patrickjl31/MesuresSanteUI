//
//  DemandeNomBis.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 04/03/2022.
//

import SwiftUI

struct DemandeNomBis: View {
    
    //@ObservedObject var patient : Personne
    @ObservedObject var users : Users
    
    @State var action : actionPossible
    @State var nom: String //= ""
    @State var prenom: String //= ""
    
    @State var nomOrigine: String = ""
    @State var prenomOrigine: String = ""
    
    @State var modifier : Bool = false
    @State var creer : Bool = false
    @State private var showAlert: Bool = false
    
    //@State private var  nomOrigine:String = ""
    //@State private var  prenomOrigine:String = ""
    
    
    func enregistrer(){
        if action == .creer {
            users.addNewUser(nom: nom, prenom: prenom)
        } else {
            users.changeIdentityFrom(nom: nomOrigine, prenom: prenomOrigine, toNom: nom, toPrenom: prenom)
        }
        //print("enregistré, action : \(action)")
    }
    func ecrireCANCEL(){
        //print("Annuler")
    }
    
    func validation(){
        //var personne = datas.patient
       let modification = (nom != nomOrigine) || (prenom != prenomOrigine)
        
        if (nom.count > 0) && (prenom.count > 0) && modification {
            //print("Nom: \(nom), prénom : \(prenom),ancien Nom: \(nomOrigine), prenom : \(prenomOrigine) ")
            /*
            
            Alert(title: Text("Validation ?"), message: Text("Voulez vous réellement enregistrer \(prenom), \(nom) ?"), primaryButton: .default(
                Text("Annuler"),action: ecrireCANCEL), secondaryButton:.destructive(Text("OK"),action: enregistrer
             )
            )
            //print("Alerte vue")
             */
            
            if action == .creer {
                users.addNewUser(nom: nom, prenom: prenom)
                //print("écriture faite, action : \(action)")
            } else {
                users.changeIdentityFrom(nom: nomOrigine, prenom: prenomOrigine, toNom: nom, toPrenom: prenom)
                //print("écriture faite, action : \(action)")
            }
            //print("écriture faite, action : \(action)")
            //nom = ""
            //prenom = ""
        }
    }
    
    func identiteRenseignee()-> Bool{
        return (nom.count > 0) && (prenom.count > 0)
    }

   
    
    var body: some View {
        
        VStack{
            if !identiteRenseignee(){
                Text("Qui êtes-vous ?")
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundColor(Color("BleuSombre"))
            } else {
                Text("Bonjour \(prenom) \(nom),")
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .foregroundColor(Color("BleuSombre"))

            }
            HStack{
                VStack{
                    Button {
                        //patient.effaceIdentite()
                        nom = ""
                        prenom = ""
                        action = .creer
                        print("Valider?")
                        } label: {
                            VStack( spacing: 0){
                            Image(systemName: "highlighter")
                            Text("Nouveau")
                                .font(.system(size: 16, weight: .light))
                            }
                            .font(.system(size: 18, weight: .light))
                    }
                    
                    Button {
                    //patient.effaceIdentite()
                    //nom = ""
                    //prenom = ""
                    //modifier.toggle()
                    action = .Modifier
                    //print("Valider?")
                    //validation()
                    } label: {
                        VStack( spacing: 0){
                            Image(systemName: "highlighter")
                            Text("Modifier")
                                .font(.system(size: 16, weight: .light))
                    }

                }
                
                    .font(.system(size: 18, weight: .light))
                }
                
                Spacer(minLength: 50)
                VStack{
                    
                    VStack {
                        HStack {
                            Text("Nom : ")
                            TextField("Votre nom :", text: $nom)
                        }
                        HStack {
                            Text("Prénom : ")
                            TextField("Votre prénom :", text: $prenom)
                            }
                        }
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color("BleuSombre"))
                    .padding(.horizontal, 10)
                }
                
                }
            
            Button {
                showAlert = true
                
                //var personne = datas.patient
                validation()
                
            }
        label: {
                //Text("Valider")
                BlocBouton(texte: "Valider")
            }

        }
        .padding(.horizontal, 10)
    }
}

struct DemandeNomBis_Previews: PreviewProvider {
    static var previews: some View {
        DemandeNomBis(users: Users(), action: .creer, nom: "marcel", prenom: "leon")
    }
}
