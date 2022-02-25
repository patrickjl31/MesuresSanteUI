//
//  CercleVue.swift
//  dessine un cecle de centre centre, diametre
//et option couleur intérieure et extérieure
//
//  Created by patrick lanneau on 18/12/2020.
//

import SwiftUI

struct CercleVue: View {
    
    var centre:CGPoint
    var diametre : CGFloat
    var colorInt = Color.yellow
    var colorExt = Color.red
    
    var legende : String = ""
    
    @State var tapped = false
    
    var body: some View {
        
        ZStack {
            /**/
            Circle()
                .stroke(colorExt, lineWidth: 4.0)
                .frame(width: diametre, height: diametre, alignment: .center)
                .position(x: centre.x, y: centre.y)
                .overlay(Circle()
                            .fill(colorInt)
                            .frame(width: diametre, height: diametre, alignment: .center)
                            .position(x: centre.x, y: centre.y)
                )
                .onTapGesture {
                    // afficher fenetre fottante
                    tapped.toggle()
            }
            
            if legende.count > 0 {
            // la boite
            Text(legende)
                    
                .foregroundColor(Color("BleuNoir"))
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .frame(width: 100, height: 50, alignment: .center)
                //.border(Color.blue, width: 1)
                .background(Color("JauneClair"))
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .shadow(color: .brown, radius: 4, x: 0, y: 3)
                
                .cornerRadius(10)
                .opacity(tapped ?1 : 0)
                //.offset(y: 29)
                .position(x: centre.x, y: centre.y + 40)
                
                
            }
            
        }
    }
}

struct CercleVue_Previews: PreviewProvider {
    static var previews: some View {
        CercleVue(centre: CGPoint(x: 150.0, y: 150.0), diametre: 20, legende: "rien\n n'est \ntrop")
            //.previewLayout(PreviewLayout.sizeThatFits)
    }
}
