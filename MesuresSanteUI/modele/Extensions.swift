//
//  Extensions.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 13/02/2022.
//

import Foundation


extension Date {
    
    /*
    func tuString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY , hh:mm"
        // Convert Date to String
        return dateFormatter.string(from: date)

    }
     
     
     func stringToDate(string:String)->Date?{
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd/MM/YY , hh:mm"
         // Convert Date to String
         
         return dateFormatter.date(from:  string)!

     }
     
     
     */
    
    
    
    func toString(withFormat format: String = "dd/MM/YY , hh:mm, a") -> String {

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "fr-FR")
            //dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
            dateFormatter.dateFormat = format
            let str = dateFormatter.string(from: self)

            return str
        }
    
    
}

extension String {

    func toDate(withFormat format: String = "dd/MM/YY , hh:mm, a")-> Date?{

        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fr-FR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
