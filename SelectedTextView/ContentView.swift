//
//  ContentView.swift
//  SelectedTextView
//
//  Created by Kilian on 21.03.20.
//  Copyright © 2020 Kilian. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var keyboardHeight: CGFloat = 0
    var body: some View {
        SelectedTextView(keyboardHeight: $keyboardHeight)
            .padding()
            .frame(maxHeight: 100, alignment: .bottom)
            .offset(y: -keyboardHeight)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
