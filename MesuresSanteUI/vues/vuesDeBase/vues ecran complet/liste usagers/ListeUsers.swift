//
//  ListeUsers.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 28/02/2022.
//

import SwiftUI

struct ListeUsers: View {
    
    @ObservedObject var users: Users
    
    func construit(){
        users.toTest()
    }
    
    var body: some View {
        //construit()
        
        List{
            VStack{
                ForEach (1..<5) {index in
                    Text("\(index)")
                }
            }
        }
        .listStyle(.grouped)
    }
    
    
}

struct ListeUsers_Previews: PreviewProvider {
    static var previews: some View {
        ListeUsers(users: testUsers)
        //ListeUsers()
    }
}
