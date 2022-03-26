//
//  PeriodeView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 19/02/2022.
//

import SwiftUI

struct PeriodeView: View {
    
    @ObservedObject var patient : Personne
    //@ObservedObject var datas : Mesures
    var typeMesure: String = TENSIONS
    
    // MARK: - Fonctions
    
    func laDate(date:Date)->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "FR-fr")
        format.dateFormat = "EEEE dd MMMM yyyy"
        return format.string(from: date)
        
    }
    
    func bornesEnString()->String {
        var rep = ""
        //var lesMesures = patient.tension.maTension
        if typeMesure == SUCRE {
            let lesMesures = patient.diabete.sucre
            if lesMesures.count > 2 {
                // au moins 2 mesures
                let date1 = laDate(date:  lesMesures[0].dateMesure)
                let date2 = laDate(date: lesMesures[lesMesures.count - 1].dateMesure)
                //let date2 = laDate(date: lesMesures.last?.dateMesure ?? Date())
                rep = "Mesures du \(date1) au \(date2)"
                return rep
            } else {
                if lesMesures.count == 2 {
                    // une mesure
                    let date1 = laDate(date:  lesMesures[0].dateMesure)
                    let date2 = laDate(date: lesMesures[1].dateMesure)
                    rep = "Mesures du \(date1)\n au \n\(date2)"
                } else {
                    // Rien
                    return  "Pas encore assez de mesures..."
                }
            }
        } else {
            let lesMesures = patient.tension.maTension
            if lesMesures.count > 2 {
                // au moins 2 mesures
                let date1 = laDate(date:  lesMesures[0].dateMesure)
                let date2 = laDate(date: lesMesures[lesMesures.count - 1].dateMesure)
                rep = "Mesures du \(date1)\n au \n\(date2)"
                return rep
            } else {
                if lesMesures.count == 2 {
                    // une mesure
                    let date1 = laDate(date:  lesMesures[0].dateMesure)
                    let date2 = laDate(date: lesMesures[1].dateMesure)
                    rep = "Deux  mesures : \(date1) et \(date2)"
                } else {
                    // Rien
                    return  "Pas encore assez de mesures..."
                }
            }
            
        }
        return rep
    }
    // MARK: - Corps
    var body: some View {
        Text(bornesEnString())
            .modifier(PetitBleuModifier())
            .multilineTextAlignment(.center)
            .lineLimit(4)
        /*
            .font(.system(size: 18, weight: .heavy, design: .rounded))
            .foregroundColor(Color("BleuSombre"))
            .multilineTextAlignment(.center)
            .lineLimit(3)
        */
    }
}

struct PeriodeView_Previews: PreviewProvider {
    static var previews: some View {
        //PeriodeView(patient: Personne(), datas: testMesures)
        PeriodeView(patient: Personne(),typeMesure:  SUCRE)
    }
}
