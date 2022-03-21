//
//  SaisieSucreView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 12/02/2022.
//

import SwiftUI

struct SaisieSucreView: View {
    @ObservedObject var user : Users
    
    //@ObservedObject var patient : Personne
    //@ObservedObject var datas : Mesures
    
    
    // MARK: - Propriétés
    
    @State var tauxSucreG : Double = 0
    @State var tauxSucreMmol : Double = 0
    @State var taux:Double = 1
    @State var dateDuReleve : Date = Date()
    @State var pulse:Bool = false
    
    @State var moment:Int = 1
    @State var niveauGlycemie:Int = 1
    @State var autreJour: Bool = false
    
    // pour les réglages des sliders
    @State var max1 = 6.0
    @State var min1 = 0.1
    @State var max2 = 6 * 5.5
    @State var min2 = 0.1 * 5.5
    //@State var mid1 = 1.0
    //@State var mid2 = 20.0
    @State var showAlert: Bool = false
    // MARK: - Fonctions
    func laDate(date:Date)->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "FR-fr")
        format.dateFormat = "EEEE dd MMMM yyyy"
        return format.string(from: date)
        
    }
    
    // retourne en clair le choix du moment de la prise
    func itemMoment(val:Int)->String{
        let moments = Moment.allCases
        var rep : String = ""
        switch val{
        case 0: rep = moments[0].rawValue
        case 1: rep = moments[1].rawValue
        case 2: rep = moments[2].rawValue
        case 3: rep = moments[3].rawValue
        case 4: rep = moments[4].rawValue
        case 5: rep = moments[5].rawValue
        default:rep = moments[0].rawValue
        }
        return rep

    }
    
    func setValuesSlidersForLevel(level : Int)->(Double,Double){
        var maxi1: Double
        var mini1: Double
        switch niveauGlycemie{
        case 0:
            maxi1 = 0.7
            mini1 = 0.1
        
        case 1:
            maxi1 = 1.5
            mini1 = 0.6
        case 2:
            maxi1 = 1.8
            mini1 = 1.3
        case 3:
            maxi1 = 4
            mini1 = 1.7
        
        default:
            maxi1 = 1.5
            mini1 = 0.6
        }
        
        return (maxi1, mini1)
    }
    
    func testCompatiblite(date:Date, choix: Int)->Bool{
        guard choix > -1 && choix < 8 else {return false}
        let heure = Calendar.current.component(.hour, from: date)
        if (heure < 8) && (choix == 0){
            return true
        }
        if (heure > 10)  && (heure < 12) && ((choix == 1) || (choix == 2))   {
            //|| (choix == 2))
            return true
        }
        if (heure > 16)  && (heure < 18) && ((choix == 3) || (choix == 4))  {
            return true
        }
        if (heure < 16)  && (heure < 18) &&  (choix == 4){
            return true
        }
        /*
        if (heure < 18)  && (heure < 20)   && (choix == 5){
            return true
        }
         */
        if (heure > 22) && (choix == 5){
            return true
        }
        return false
    }

    

    func enregistrer(){
        //let newGlycemie = Glycemie(jour: dateDuReleve, duSucre: taux)
        //newGlycemie.sucre = taux
        //newGlycemie.date = dateDuReleve
        
        // définir le moment
        if !autreJour {
            dateDuReleve = Date()
        }
        let test = testCompatiblite(date: dateDuReleve, choix: niveauGlycemie)
        if !test {
            //
        }
        let leMoment: String = itemMoment(val: moment)
        let newDiabete = MesureSucre(taux: taux, dateMesureS: "", dateMesure: dateDuReleve, itemMomentMesure: moment ,moment: leMoment)
        
        user.addMesureSucre(sucre: newDiabete)
        
    }
    
    func setDate(){
        if !autreJour{
            dateDuReleve = Date()
        }
    }
    
    // MARK: - Body
    // 1g = 14,5 mmol
    var body: some View {
        
        
        NavigationView {
        ZStack {
            FondEcranSucreView()
            
            VStack{
                   
                let animation = Animation
                    .linear(duration: 1.0)
                    .repeatForever(autoreverses: false)

                EnTeteSucre()
                    .padding(.bottom, 5)
                                /* */
                    .scaleEffect(pulse ? 1.0 : 0.7)
                        //.animation(.easeIn(duration: 1).repeatForever(autoreverses: true) )
                    .onAppear(){
                        DispatchQueue.main.async {
                        // << postpone till end of views construction !!
                        //pulse = true
                            withAnimation(animation) {
                                pulse = true
                            }
                        }
                            //pulse.toggle()
                    }
                   
                    //DateDuJourView()
                        //.padding(.vertical, 10)
                    //Spacer()
                SaisieDate(releveDu: $dateDuReleve, autreJour: $autreJour)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("BleuSombre"))
                    .shadow(color: Color("BlackLigth"), radius: 3, x: 0, y: 4)
                    .padding(.vertical, 10)
                //setDate()
                //Text("Mesures réalisées le \(dateDuReleve.identDateAndMoment().date) (\(dateDuReleve.identDateAndMoment().moment))")
                    
                
                
                HStack {
                    Spacer()
                    RadioButtonsView(questions: SListeMomentsSucre, choosed: $moment,nbColones: 1,direction: .droite)
                        .modifier(RadioButtonsModifier())
                    //RadioButtonsView(questions: ["Réveil", "Apres petit déjeuner", "Avanr déjeuner", "Après déjeuner", "Avant diné", "Couché"], choosed: $moment,nbColones: 1,direction: .droite)
                        .modifier(RadioButtonsModifier())
                }
                
                RadioButtonsView(questions: ["Hypoglycémie (< 0.7)", "Normal (0.7...1,4)", "Hyperglycémie modérée (1,4...1,7)", "Diabete ( > 1.7)", ], choosed: $niveauGlycemie,nbColones: 1, direction: .gauche)
                    .modifier(RadioButtonsModifier())
                    .padding(.bottom, 10)
                //Text("\(niveauGlycemie) , tapé : \(setValuesSlidersForLevel(level: niveauGlycemie).0) ")
                
                DoubleSliderView(valeur: $taux, titre1: "Taux en Grammes / litre", titre2: "Taux en mmol / litre", mini1: setValuesSlidersForLevel(level:  niveauGlycemie).1, maxi1: setValuesSlidersForLevel(level:  niveauGlycemie).0, pas: 0.01, precision: 2, couleur1: .blue, couleur2: .red)
                //DoubleSliderView(valeur: $taux, titre1: "Taux en Grammes / litre", titre2: "Taux en mmol / litre", mini1: setValuesSlidersForLevel().1, maxi1: setValuesSlidersForLevel().0, mini2: min2, maxi2: max2, pas: 0.01, precision: 2, couleur1: .blue, couleur2: .red)
                    
                    if taux > 1.7 {
                        Text("Attention vous êtes en danger !")
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .foregroundColor(.red)
                    }
                    if taux < 0.7 {
                        Text("Attention vous êtes en hypoglycémie !")
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .foregroundColor(.red)
                    }
                    
                    Button {
                        if !autreJour {
                            dateDuReleve = Date()
                        }
                        let test = testCompatiblite(date: dateDuReleve, choix: niveauGlycemie)
                        if !test {
                            showAlert = true
                        } else {
                            enregistrer()
                        }
                        
                    } label: {
                        BlocBouton(texte: "Enregister cette mesure")
                    }
                    .padding(.vertical , 30)
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Le moment choisi ne semble pas correspondre à l'heure de l'enregistrement !"), message: Text("Dois-je enregistrer ce choix ?"), primaryButton: .default(Text("OK")){
                            enregistrer()
                            // user.deleteAllTension()
                            //datas.deleteAll()
                        }, secondaryButton: .cancel())
                })
    //---------------------------------
  
            //-----------------------------------------
            
                
            .toolbar {
                 
                /* */
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        //let patient: Personne = user.listeUsers[user.userCourant]
                        if user.existCurrentUser(){
                        CourbeSucreView(patient: user.listeUsers[user.userCourant],choixtoutesMesures: true, choixPrePrandial: true)
                        }
                        /*
                        CourbeSucreView(patient: user.listeUsers[user.userCourant])
                        }
                         */
                        //ListeSucreView(user: user, patient: patient)
                    } label: {
                        VStack{
                            //Image(systemName: "waveform.path.ecg.rectangle")
                            Image(systemName: "chart.xyaxis.line")
                            Text("Courbes")
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                        }
                        .font(.system(size: 18, weight: .light, design: .rounded))
                    }
                }
                
                

                    ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        
                        ListeSucreView(user: user)
                    } label: {
                        VStack{
                            Image(systemName: "list.bullet.rectangle")
                            Text("Tous les \nenregistrements")
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                        }
                        .font(.system(size: 18, weight: .light, design: .rounded))
                    }
                }
               
                
            }
                 //fin de toolbars
             
        }// VStack
            
        }//Navigation view
        .navigationViewStyle(StackNavigationViewStyle())
        .padding(.horizontal, 10.0)
        
        }
    }
}

struct SaisieSucreView_Previews: PreviewProvider {
    static var previews: some View {
        //SaisieSucreView(patient: Personne(), datas: Mesures())
        //SaisieSucreView(user: Users(), patient: Personne())
        SaisieSucreView(user: Users())
    }
}
