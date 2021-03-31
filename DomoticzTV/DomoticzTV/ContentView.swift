//
//  ContentView.swift
//  DomoticzTV
//
//  Created by Michał Solski on 30/03/2021.
//

import SwiftUI
import DomoticzSwift

struct ContentView: View {
    var body: some View {
        Text(DomoticzSwift().helloMsg)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
