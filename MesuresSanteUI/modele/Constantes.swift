//
//  Constantes.swift
//  tension (iOS)
//
//  Created by patrick lanneau on 07/12/2020.
//

import Foundation
import SwiftUI


// Conversion json to excel :
//
//   https://data.page/json/csv
//-------------------------------------


let USERS = "users"
let PATIENT = "patient"
let CURRENT_USER = "CurrentUser"
let TENSIONS = "Tension"
let SUCRE = "Sucre"
let RAPPORT = "Rapport"

// Nom du fichier des tensions
let NOM_FICHIER_TENSIONS = "tensions"
let NOM_FICHIER_SUCRE = "sucre"
let NOM_FICHIER_PERSONNE = "personne"
let NOM_FICHIER_RAPPORT = "rapport"

//couleurs
let COUL_SYSTO = Color.red
let COUL_DIASTO = Color.blue
let COUL_COEUR = Color.purple
let COUL_OXY = Color.brown

// Noms des symboles utilisés
let SYMBOLE_COEUR = "heart.circle"
let SYMBOLE_COUVERT = "fork.knife.circle"
let SYMBOLE_CUP = "cup.and.saucer"
let SYMBOLE_CUBE = "cube"
let SYMBOLE_TROUSSE_MEDICALE = "cross.case"
let SYMBOLE_OEIL = "eye"

// Sucre
let SListeMomentsSucre = ["Réveil", "Après petit déjeuner", "Avanr déjeuner", "Après déjeuner", "Avant diner", "Couché"]
let SListeMomentsPreSucre = ["Réveil",  "Avanr déjeuner", "Avant diner"]
let SListeMomentsPostSucre = ["Après petit déjeuner", "Après déjeuner", "Couché"]

let ListeMomentsSucre:[Moment] = [.reveil, .apresPetitDej, .avantDej, .apresDej, .avantDine, .couche]
let ListeMomentsPreSucre:[Moment]  = [.reveil, .avantDej, .avantDine]
let ListeMomentsPostSucre:[Moment]  = [.apresPetitDej, .apresDej, .couche]

let ListeNiveauxGlycemie = ["Hypoglycémie (< 0.7)", "Normal (0.7...1,4)", "Hyperglycémie modérée (1,4...1,7)", "Diabete ( > 1.7)"]
//limites du nombre de mesures
let NOMBRE_MAX_MESURES_SUCRE = 6 * 100
let NOMBRE_MAX_MESURES_TENSION = 2 * 100
let NOMBRE_MAX_MESURES_QUOTIDIEN = 2 * 100

// Textes de Help

let T0_HELP0 = "Surveillez votre santé au jour le jour..."
let T1_HELP0 = "Votre carnet de suivi santé."

let ScreenWidth = UIScreen.main.bounds.size.width


let T0_HELP = "Surveillez votre santé..."
let T1_HELP = "Tenez à jour vos constantes..."

let HELP = """

Votre carnet de suivi santé vous offre trois  outils complémentaires pour enregistrer les constantes de santé qui serviront à votre médecin, à vos infirmiers, pour suivre l'évolution des constantes de santé au jour le jour.
Il permet tout d'abord d'enregistrer votre suivi quotidien :
- votre tempérture,
- votre diurèse,
- le niveau moyen de la douleur
^ vos selles,
- l'état cutané pour éviter les risques d'escares
- votre moral.
Il permet aussi d'enregistrer des remaeques diverse

C'est sur cette page que s'ouvre l'application pour enregistrer un suivi quotidien général

Les iconnes du bas d'écran permettent d'accéder aux autre outils, suivi de tension et suivi de glycémie.
Pour chacune de ces données vous pouvez accéder à la liste complète des enregistrements
-
"""


let T0_HELP1 = "Surveillez votre tension artérielle..."
let T1_HELP1 = "Votre santé en dépend."
let HELP1 = """

La page Tension à votre disposition permet d'assurer le suivi de votre tension.
Il vous permet d'enregistrer vos mesures (Tension systolique, tension distolique, fréquence cardiaque) à un moment donné, puis , de les présenter  sous forme graphique.
Chaque prise de tension est enregistrée au moyen de cureurs. Il est recommandé de faire plusieurs mesures à intervalles rapprochés l'application fera une moyenne de ces mesures pour éviter les mesures aberrantes ( mauvaise prise de tension, événement perturbateur...) Lorsque vous avez pris quelques mesures, vous pouvez enrgistrer cette mesure moyenne.
Depuis cette page, vous pouvez accéder à la liste des mesures, et à leur présentation sous forme de courbes ou d'histogrammes.
"""

let T0_HELP2 = "Surveillez votre glycémie..."
let T1_HELP2 = "Saisie."
let HELP2 = """

Par défaut, vous enregistrez votre tension de ce jour, matin ou soir. Le jour de la mesure est rappelé sur la page de saisie.
Vous pouvez cependant enregistrer la tension d'un jour passé en activant "Saisir le relevé d'un autre jour ?". Dans ce cas, l'application vous deemandera de préciser le jour et la demi journée (PM ou AM).
Vous indiquerez votre mesur au moyen des 3 curseurs.
Lorsque le bouton "Ajouter cette mesure apparait, vous pouvez le toucher. Votre saisie sera alors rappelée en dssous des curseurs.
Si vous avez réalisé d'autres mesures dans la même période, vous pouvez les enregistrer. L'application calculera alors la moyenne de vos mesures.
Lorsque vous aurez enregistré toute les mesures de ce matin ou ce soir là, touchez le bouton "Enregistrer cette série" pour enregistrer la moyenne de ces mesures.
Par défaut, l'application enregistre la date et l'heure de l'enregistrement, mais vous pouvez modifier ces informations pour une mesure si nécessaire.
"""

let T0_HELP3 = "Afficher les résultats"
let T1_HELP3 = "Le diabète, la rension, doivent être surveillés régulièrement."
let HELP3 = """

Cette page vous permet d'enregistrer une glycémie à l'aide de boutons curseurs. Vous avez le choix entre une mesure en grammes par litre ou en mmol. Les deux cursseurs sont dorélés.
Vous pouvez accéder à la liste des mesures pour les corriger éventuellement
"""

let T0_HELP4 = "Communiquer..."
let T1_HELP4 = "Vos mesures sont enregistrées et exportables"
let HELP4 = """

Toutes les mesures sont enregistrées en permanence au format JSON. Vous pouvez ainsi les récupérer dans un tableur ou les communiquer à vote médecin.

"""


// MARK: - constantes machine
let screenHeight = UIScreen.main.bounds.size.height
var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

// MARK: - monétisation - admob
//Constantes AdMob
//!!! A utiliser uniquement en production

let ADMOB_APP_ID = ""
let BANNER_ID = ""
let INTERSTITIAL_ID = ""
let VIDEO_ID = ""

// Constantes AdMob TEST
let TEST_BANNER = ""
let TEST_INTERSTITIAL = ""
let TEST_VIDEO = ""

//Test Devices
let TEST_DEVICES = [
    ""
]



// MARK: - pour les tests

let heigthScreen = UIScreen.main.bounds.size.height
/*
//let TestValues = [14.0,12.0,8.0,16.0,7.6,12.5,14.0,12.0,8.0,16.0,7.6,12.5,14.0,12.0,8.0,16.0,7.6,12.5]
let j: Double = 60 * 60 * 24
var mesuresTest = Mesures()
mesuresTest.maTension = [
    Mesure(systolique: 14, distolique: 5.4, pulsation: 78, dateMesure: Date(timeIntervalSinceNow: j), moment: "MATIN"),
    Mesure(systolique: 18, distolique: 6.3, pulsation: 84, dateMesure: Date(timeIntervalSinceNow: j * 2), moment: "MATIN"),
    Mesure(systolique: 12, distolique: 8.3, pulsation: 65, dateMesure: Date(timeIntervalSinceNow: j * 3), moment: "MATIN"),
    Mesure(systolique: 13, distolique: 9.2, pulsation: 46, dateMesure: Date(timeIntervalSinceNow: j * 4), moment: "MATIN"),
    Mesure(systolique: 10, distolique: 7.5, pulsation: 86, dateMesure: Date(timeIntervalSinceNow: j * 5), moment: "MATIN"),
    Mesure(systolique: 14, distolique: 6.8, pulsation: 78, dateMesure: Date(timeIntervalSinceNow: j * 6), moment: "MATIN")
    
]
 
 
 
var testSucre = MesuresSucre()
testSucre.sucre = [
    MesureSucre(taux: 1.3, dateMesure: Date(), moment: "AM"),
    MesureSucre(taux: 1.8, dateMesure: date + (1 * demiJour), moment: "AM"),
    MesureSucre(taux: 1.1, dateMesure: date + (2 * demiJour), moment: "PM"),
    MesureSucre(taux: 1.7, dateMesure: date + (3 * demiJour), moment: "AM"),
    MesureSucre(taux: 0.5, dateMesure: date + (4 * demiJour), moment: "PM"),
    MesureSucre(taux: 1.9, dateMesure: date + (5 * demiJour), moment: "AM"),
    MesureSucre(taux: 1.0, dateMesure: date + (6 * demiJour), moment: "PM"),
    MesureSucre(taux: 1.6, dateMesure: date + (7 * demiJour), moment: "AM"),
    MesureSucre(taux: 1.5, dateMesure: date + (8 * demiJour), moment: "PM"),
    MesureSucre(taux: 1.2, dateMesure: date + (9 * demiJour), moment: "AM"),
    MesureSucre(taux: 1.3, dateMesure: date + (10 * demiJour), moment: "PM"),
     
     
 ]

 */



/*
let testduSucre : [MesureSucre] = [
    Glycemie(jour: Date(), duSucre: 0.4),
    Glycemie(jour: date + (1 * demiJour), duSucre: 1.3),
    Glycemie(jour: date + (2 * demiJour), duSucre: 1.7),
    Glycemie(jour: date + (3 * demiJour), duSucre: 1.1),
    Glycemie(jour: date + (4 * demiJour), duSucre: 1.3),
    Glycemie(jour: date + (5 * demiJour), duSucre: 1.6),
    Glycemie(jour: date + (6 * demiJour), duSucre: 1.1),
    Glycemie(jour: date + (7 * demiJour), duSucre: 1.5),
    Glycemie(jour: date + (8 * demiJour), duSucre: 0.6),
    Glycemie(jour: date + (9 * demiJour), duSucre: 1.9),
    Glycemie(jour: date + (10 * demiJour), duSucre: 1.3),
    Glycemie(jour: date + (11 * demiJour), duSucre: 1.2)
   
]
*/

