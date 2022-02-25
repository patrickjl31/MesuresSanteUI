//
//  HelpView.swift
//  tension (iOS)
//
//  Created by patrick lanneau on 27/12/2020.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        TabView{
            Help0()
            Help1()
            Help2()
            Help3()
            Help4()
        }
        .tabViewStyle(PageTabViewStyle())
        .background(Color("grisClair"))
        //.tabViewStyle(.page)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
