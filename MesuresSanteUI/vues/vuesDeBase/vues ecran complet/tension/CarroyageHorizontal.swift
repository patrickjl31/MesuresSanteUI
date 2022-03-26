//
//  CarroyageHorizontal.swift
//  tension
//
//  Created by patrick lanneau on 18/12/2020.
//

import SwiftUI

struct CarroyageHorizontal: View {
    
    /*
    // les la plus basse ey la plus haute
    // valeur min et max
    */
    
    var limB: CGFloat  = 1
    var limH:CGFloat  = 20
    
    // la taille du graphique
    var basDeCourbe: CGFloat = 100
    var hauteurCourbe: CGFloat = 400
    //var hauteurGraphique: CGFloat = 50
    //var hauteurBase: CGFloat = 100
    //var multi:Int = 3
    
    // MARK: - Fonctions
    func precision(ecart : CGFloat)->String {
        
        if ecart < 1.4 {
            return "%.2f"
        }
        if ecart < 15 {
            return "%.1f"
        }
        
        return "%f"
    }
    
    
    
    /*
    init() {
        //hauteurNiveau = hauteurGraphique / CGFloat(limH - limB)
    }
    */
    var body: some View {
        //let hauteurNiveau = hauteurGraphique / CGFloat(limH - limB)
        GeometryReader{geometry in
            //let ecart = (geometry.size.height / CGFloat(limH - limB)) * CGFloat(multi)
            let ecart = CGFloat( hauteurCourbe  / 10)
            // on arrondit les limites
            //let limBR:CGFloat = round(limB)
            //let limHR:CGFloat = round(limH)
            let ecartValeurs:CGFloat = limH - limB
            let entreLignes : CGFloat = ecartValeurs / 10.0
            //let ligneDuBas = geometry.size.height
            //let ecart:CGFloat = CGFloat(multi)
            let longueur = geometry.size.width - 25
            let screenHeigth = geometry.size.height
            
            //let debut = CGFloat(limB) * ecart
            //let debut = geometry.size.height - (CGFloat(limB) * ecart)
            //let debut = ligneDuBas - longueur
            // tracer les lignes
            ForEach((0...10).reversed(), id: \.self) { index in
                
                //let y = -(basDeCourbe - (ecart * CGFloat( index)))
                let y1 = (basDeCourbe + (ecart * CGFloat( index)))
                let y = screenHeigth - y1
                Path{ path in
                    path.move(to: CGPoint(x: 50, y: y))
                    path.addLine(to: CGPoint(x: longueur, y: y))
                }
                    .stroke(Color.black)
                
                //HStack {
                //Text(" \((entreLignes * CGFloat( index - 1)), specifier : "%.2f" )")
                //let legende = (String(format: "%.f", limB +  entreLignes * CGFloat( index - 1)))
                let legende = (String(format: precision(ecart: ecartValeurs), limB +  entreLignes * CGFloat( index)))
                //Text(" \((entreLignes * CGFloat( index - 1)), specifier : precision(ecart: ecart))")
                Text(legende)
                        .font(.headline)
                    //.offset(x: 1.0, y: y - 32)
                        .position(x:20, y: y)
                    
                /**/
            }
            
            /*
            // Tracer les étiquettes
            ForEach((limB...limH), id: \.self) { index in
                //let y =   debut + CGFloat(limB - index ) * ecart
                let y = -(basDeCourbe - (ecart * CGFloat( index)))
                Text("\(limH - index)")
                    .font(.headline)
                //.offset(x: 1.0, y: y - 32)
                    .position(x:10, y: y)
            }
            */
               
            
            
        }//geometry
        
        
    }
    
}

struct CarroyageHorizontal_Previews: PreviewProvider {
    static var previews: some View {
        CarroyageHorizontal(limB: 7.5, limH: 15.9)
            //.previewLayout(.sizeThatFits)
    }
}
