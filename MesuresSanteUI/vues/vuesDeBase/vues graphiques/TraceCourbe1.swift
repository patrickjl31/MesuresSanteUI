//
//  TraceCourbe1.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 12/03/2022.
//

import SwiftUI

struct TraceCourbe1: View {
    // La courbe est inversée
    
    var symbole : String = SYMBOLE_COEUR
    var listeDates:[Date] = []
    var listePointsX : [Double]
    
    var yMax:Double
    var yMin : Double
    var couleur: Color = .blue
    var basDeCourbe: CGFloat = 0
    var hauteurCourbe: CGFloat = 400
    
    
    var legende : String = ""
    // coéficient multiplicateur
    //@State var multi : Double = 3
    //var ecartement : cgfloat
    
    func setMulti()-> Double{
        let maxi = Double( listePointsX.max() ?? 0)
        let mini = Double( listePointsX.min() ?? 0)
        //multi = hauteurCourbe / maxi
        return hauteurCourbe / maxi
    }
    
    func dateCourte(d:Date)->String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr-FR")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "dd/MM/YY,hh:mm,a"
        return formatter.string(from: d)
    }

    var body: some View {
        
        GeometryReader {geometry in
            //let maxi =
            let yUnite = hauteurCourbe / (yMax - yMin)
            
            let ecartement = Double(geometry.size.width) / Double(listePointsX.count)
            let demiEcart = ecartement / 2
            
            let debut = geometry.size.height - basDeCourbe

           
            Path(){path in
                path.move(to: CGPoint(x: demiEcart, y: Double(debut) - ((listePointsX[0] - yMin) * yUnite)))
                for index in 1..<listePointsX.count{
                    path.addLine(to: CGPoint(x: demiEcart + (ecartement * Double(index))  , y: Double(debut) - ((listePointsX[index] - yMin) * yUnite)))
                    
                }
            }
             
            .stroke(couleur, lineWidth: 4)
           
          

            // Les points
            /*
            CercleVue(centre: CGPoint(x: demiEcart, y: listePointsX[0]  * multi), diametre: 10, colorInt: Color.white, colorExt: Color.red)
 */

            ForEach(0..<listePointsX.count){index in
                //let texte :String = String(listePointsX[index])
                // on indique la date
                let d = dateCourte(d: listeDates[index])
                let v = " -> \(String(format: "%.2f", listePointsX[index]))"
                let texte = listeDates.count == listePointsX.count ?"Relevé du \(d): \(v)" : ""
                //CoeurVue(centre: CGPoint(x: demiEcart + (ecartement * Double(index))  , y  : Double(debut) - ((listePointsX[index] - yMin) * yUnite)), diametre: 20, colorInt: Color.white, colorExt: couleur, legende: texte)
                PointSurCourbeVue(symbole: symbole, centre: CGPoint(x: demiEcart + (ecartement * Double(index))  , y  : Double(debut) - ((listePointsX[index] - yMin) * yUnite)), diametre: 20, colorInt: Color.white, colorExt: couleur, legende: texte)
            }
            
            //CarroyageHorizontal(limB: Int(listePointsX.min()!), limH: Int(listePointsX.max()!), multi: Int(multi))
            
        }
        
    }
}

struct TraceCourbe1_Previews: PreviewProvider {
    static var previews: some View {
        TraceCourbe1(listeDates: [Date(),Date(),Date(),Date()], listePointsX: [10.800000000000001,10.5,7.5,9.8000000000000007], yMax: 18, yMin: 3, couleur: .red)
        //TraceCourbe1(listeDates:[Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date(),Date()],listePointsX: [0.3, 14.0,12.0,8.0,16.0,7.6,12.5,14.0,12.0,8.0,16.0,7.6,12.5,14.0,12.0,8.0,16.0, 0.9,7.6,12.5, 12], yMax: 17 , yMin: 0.1 ,couleur: .red,multi: 30)
        
        //TraceCourbe(listeDates:[Date(),Date(),Date(),Date()],listePointsX: [10.800000000000001,10.5,7.5,9.8000000000000007] ,yMax: 10.8 , yMin: 5.0, couleur: .red,multi: 30)
    }
}
