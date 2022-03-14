//
//  DemandeNom.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 14/02/2022.
//

import SwiftUI

struct DemandeNom: View {
    
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
            //let nomOrigine = nom
            //let prenomOrigine = prenom
            //!identiteRenseignee()
            if action == .creer {
                
                VStack {
                    Text("Qui êtes-vous ?")
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .foregroundColor(Color("BleuSombre"))
                    HStack{
                        Button {
                            //patient.effaceIdentite()
                            nom = ""
                            prenom = ""
                            action = .Modifier
                            //print("Valider?")
                            } label: {
                                VStack( spacing: 0){
                                Image(systemName: "arrow.uturn.backward")
                                Text("Annuler")
                                    .font(.system(size: 16, weight: .light))
                                }
                                .font(.system(size: 18, weight: .light))
                        }
                        if action != .creer {
                            Button {
                                //patient.effaceIdentite()
                                nom = ""
                                prenom = ""
                                action = .creer
                                //print("Valider?")
                                } label: {
                                    VStack( spacing: 0){
                                    Image(systemName: "highlighter")
                                    Text("Nouveau")
                                        .font(.system(size: 16, weight: .light))
                                    }
                                    .font(.system(size: 18, weight: .light))
                            }
                            
                            
                        } else {
                            //////*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                            
                            
                        }
                        Spacer(minLength: 50)
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
                    if identiteRenseignee(){
                        Button {
                            validation()
                        } label: {
                            //Text("Valider")
                            BlocBouton(texte: "Valider")
                        }
                    }
                    
                }// VStack
            } else {
                // On a un nom
                VStack {
                    VStack {
                        if action == .creer {
                            Text("Qui êtes-vous ?")
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                                .foregroundColor(Color("BleuSombre"))
                            
                        } else {
                            //Text("Bonjour \(prenom) \(nom),")
                            Text("Bonjour \(users.prenomCurrentUser) \(users.nomCurrentUser),")
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                                .foregroundColor(Color("BleuSombre"))

                        }
                        
                    }
                
                HStack{
                    VStack {
                        // On peut toujours créer
                        Button {
                            nom = ""
                            prenom = ""
                            action = .creer
                            //print("créer?")
                            //validation(nomOrigine: nomOrigine, prenommOrigine: prenomOrigine)
                            //modifier.toggle()
                            } label: {
                                VStack( spacing: 0){
                                Image(systemName: "highlighter")
                                Text("Créer")
                                    .font(.system(size: 16, weight: .light))
                                }
                                .font(.system(size: 18, weight: .light))
                        }
                        
                        if action != .creer {
                            Button {
                            //patient.effaceIdentite()
                            //nom = ""
                            //prenom = ""
                                if users.existCurrentUser(){
                                    nom = users.listeUsers[users.userCourant].nom
                                    prenom = users.listeUsers[users.userCourant].prenom
                                }
                            modifier = true //.toggle()
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
                        
                        
                    }
                    Spacer(minLength: 50)
                    //identiteRenseignee()
                    if modifier {
                        VStack {
                            HStack {
                                Text("Nom : ")
                                TextField("Votre nom :", text: $nom)
                                    //.foregroundColor(.gray)
                                //TextField("Votre nom :", text: $nom)
                            }
                            HStack {
                                Text("Prénom : ")
                                TextField("Votre prénom :", text: $prenom)
                                }
                        }
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color("BleuSombre"))
                    .padding(.horizontal, 10)
                    } else {
                        /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                    }
                }
                    if identiteRenseignee() && modifier{
                        Button {
                            showAlert = true
                            
                            //var personne = datas.patient
                            validation()
                        }
                    label: {
                            //Text("Valider")
                            BlocBouton(texte: "Valider")
                        }
                     //-----------------
                        /*
                        BlocBouton(texte: "Validation")
                            .onTapGesture {
                                showAlert = true
                            }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Validation ?"), message: Text("Voulez vous réellement enregistrer \(prenom), \(nom) ?"), primaryButton: .default(
                                Text("Annuler"),action: ecrireCANCEL), secondaryButton:.destructive(Text("OK"),action: validation
                                                                                                )
                            )
                        }
                         
                         */
//------------------------------------------
                        
                    }
                    
                    
            }// VStack
                
        }// Else
            
    
    /*
            //let appellation =
            if action == .creer {
                Text("Qui êtes-vous ?")
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundColor(Color("BleuSombre"))
            } else
            {
                //nomOrigine = nom
                //prenomOrigine = prenom
                Text("Bonjour \(prenom) \(nom),")
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundColor(Color("BleuSombre"))
            }
            Group {
                HStack {
                    let message = (action == .creer) ? "Créer nouveau" : "Modifier"
                    
                    Button {
                        //patient.effaceIdentite()
                        nom = ""
                        prenom = ""
                        } label: {
                        VStack( spacing: 0){
                            Image(systemName: "highlighter")
                            Text(message)
                                .font(.system(size: 18, weight: .light))
                            }
                        .font(.system(size: 28, weight: .light))
                        }
                    
                    VStack {
                        HStack {
                            Text("Nom : ")
                            TextField("Votre nom :", text: $nom)
                                //.foregroundColor(.gray)
                            //TextField("Votre nom :", text: $nom)
                        }
                        HStack {
                            Text("Prénom : ")
                            TextField("Votre prénom :", text: $prenom)
                            }
                    }
                }
                
                
            }
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .foregroundColor(Color("BleuSombre"))
            .padding(.horizontal, 10)
          
            Button {
                //var personne = datas.patient
                validation(nomOrigine: nomOrigine, prenommOrigine: prenomOrigine)
                
            } label: {
                //Text("Valider")
                BlocBouton(texte: "Valider")
            }

        }
    }
    */
        }
        .padding(.horizontal, 10)
    }
}

struct DemandeNom_Previews: PreviewProvider {
    static var previews: some View {
        DemandeNom(users: Users(), action: .creer, nom: "marcel", prenom: "leon")
        //DemandeNom(datas: <#Mesures#>, nom: .constant(""))
    }
}



/*

 enum actionPossible {
     case creer,
     Modifier
 }
 
 
 
    .alert(isPresented: $showAlert) {
        Alert(title: Text("Validation ?"), message: Text("Voulez vous réellement enregistrer \(prenom), \(nom) ?"), primaryButton: .default(
            Text("Annuler"),action: ecrireCANCEL), secondaryButton:.destructive(Text("OK"),action: ecrireOK
                                                                               )
        )
    }


//----------------

Button {
    showAlert = true
    
    //var personne = datas.patient
    validation(nomOrigine: nomOrigine, prenommOrigine: prenomOrigine)
    
}

label: {
    //Text("Valider")
    BlocBouton(texte: "Valider")
}

 
 */
 
 
 
 
 
 
 
 
 
