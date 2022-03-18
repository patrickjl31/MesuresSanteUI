//
//  SucrePointVue.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 16/03/2022.
//

import SwiftUI

struct SucrePointVue: View {
    
    var centre:CGPoint
    var diametre : CGFloat
    var colorInt = Color.yellow
    var colorExt = Color.red
    
    
    var legende : String = ""
    
    @State var tapped = false
    
    var body: some View {
        ZStack {
            Image(systemName: "fork.knife.circle")
                .resizable()
                .foregroundStyle(.red, .black)
                .foregroundColor(.red)
                .frame(width: diametre, height: diametre, alignment: .center)
            .position(x: centre.x, y: centre.y)
            .onTapGesture {
                // afficher fenetre fottante
                tapped.toggle()
        }
            
            if legende.count > 0 {
            // la boite
            Text(legende)
                    
                .foregroundColor(Color("BleuNoir"))
                .font(.system(size: 10, weight: .medium, design: .rounded))
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
                .onTapGesture {
                    tapped.toggle()
                }
                
            }
            
            
        }
    }
}

struct SucrePointVue_Previews: PreviewProvider {
    static var previews: some View {
        SucrePointVue(centre: CGPoint(x: 150.0, y: 50.0), diametre: 50, legende: "rien")
    }
}
