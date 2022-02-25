//
//  RapportQuotidien.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 14/02/2022.
//

import Foundation

class RapportQuotidien:Codable, Identifiable {
    var id = UUID()
    var date = Date()
    var selles : Int = 0
    var diurese: Double = 0.0 //pipi
    var douleur : Int = 0
    var temperature : Double = 37.9
    var etatCutane:String = ""
    var moral : String = ""
    var remarques : String = ""
    
}
