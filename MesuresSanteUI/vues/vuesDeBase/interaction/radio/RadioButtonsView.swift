//
//  RadioButtonsView.swift
//  MesuresSanteUI
//
//  Created by patrick lanneau on 15/03/2022.
//

import SwiftUI

struct RadioButtonsView: View {
    
    var questions : [String]
    @Binding var choosed:Int
    @Binding var isChanged : Bool// = false
    var nbColones : Int = 1
    var direction: Orientation = .droite
    
    @State var questionsEnColones :[[String]] = []
    
    // MARK: - Fonctions
    // transforme 10,11.20,21,30,31 EN 3.4.5.6,7
    func binaireToDec(val : Int)-> Int {
        let unite = val % 10
        let dizaine = (val / 10) * 2
        return dizaine + unite
    }
    
    func dispatchEnColones()->[[String]]{
        var newQuestions  :[[String]] = []
        if nbColones > 1 {
            let impair = questions.count % 2
            let nblignes = questions.count / 2
            for ligne in stride(from: 0, to: questions.count - 1, by: 2) {
                if ligne <= nblignes{
                    let temp = [questions[ligne], questions[ligne + 1]]
                    newQuestions.append(temp)
                } else {
                    let temp = [questions[ligne]]
                    newQuestions.append(temp)
                }
                
            }
            if impair == 1 {
                let temp = [questions[questions.count - 1]]
                newQuestions.append(temp)
            }
        } else {
            newQuestions = [questions]
        }
        return newQuestions
    }
    
    var body: some View {
        VStack(alignment: direction == .droite ? .trailing : .leading, spacing: 5) {
            let t = dispatchEnColones()
            //Text("nblignes : \(questions.count / 2) longueur de t : \(t[0].count) et au depart \(questions.count)")
            //Text("\(t[0][0]),\(t[0][1]),\(t[1][0]),\(t[1][1]),\(t[1][0])")
            /*
             */
            if nbColones > 1 {
                //let t = dispatchEnColones()
                ForEach((0..<t.count) , id:\.self){item in
                    HStack(alignment: .center, spacing: 5) {
                       //Spacer()
                        ForEach((0..<t[item].count) , id:\.self){elem in
                            let pourtag: Int = binaireToDec(val: (item * 10) + elem)
                            RadioButton(Texte: t[item][elem], tag: pourtag, choosed: $choosed, isChanged: $isChanged, direction: elem == 0 ? .droite :.gauche)
                           
                        }
                        //Spacer()
                    }
                }
                
            } else {
                ForEach((0..<questions.count) , id:\.self){index in
                    RadioButton(Texte: questions[index], tag: index, choosed: $choosed, isChanged: $isChanged, direction: direction)
                }
            }
            
             
            //Text("choisi : \(choosed)")
            /*
             
            ForEach((0..<questions.count) , id:\.self){index in
                RadioButton(Texte: questions[index], tag: index, choosed: $choosed, isChanged: true)
            }
             */
        }
    }
}

struct RadioButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        //RadioButtonsView(questions: ["Choix1","Choix1","Choix2","Choix3","Choix4", choosed: .constant(1))
        RadioButtonsView(questions: ["Le bon Choix0","Choix1","Choix2","Choix3 à évifer si possible","Choix4"], choosed: Binding<Int>.constant(1), isChanged: .constant(false), direction: .gauche)
    }
}
