//
//  PickerDate.swift
//  tension
//
//  Created by patrick lanneau on 10/12/2020.
//

import SwiftUI

struct PickerDate: View {
    
    @State var date: Date = Date()
    
    var body: some View {
        DatePicker(selection: $date, label: { Text("Relevés du :") })
    }
}

struct PickerDate_Previews: PreviewProvider {
    static var previews: some View {
        PickerDate(date: Date())
            .previewLayout(.sizeThatFits)
    }
}
