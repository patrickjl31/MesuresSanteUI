//
//  DateDuJourView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 18/02/2022.
//

import SwiftUI

struct DateDuJourView: View {
    // MARK: - Ptopriétés
    var date : Date = Date()
    
    
// MARK: - Fonctios

    func laDate(date:Date)->String{
        let format = DateFormatter()
        format.locale = Locale(identifier: "FR-fr")
        format.dateFormat = "EEEE dd MMMM yyyy"
        return format.string(from: date)
        
    }
    
    
    var body: some View {
        
       
        
        Text("Le \(laDate(date: date))")
            .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundColor(Color("BleuSombre"))
                .shadow(color: Color("BlackLigth"), radius: 0, x: 0, y: 4)
    }
}



struct DateDuJourView_Previews: PreviewProvider {
    static var previews: some View {
        DateDuJourView()
    }
}
