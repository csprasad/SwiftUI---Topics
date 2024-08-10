//
//  ContentView.swift
//  SwiftUI Topics
//
//  Created by CS Prasad on 09/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BlendModeUIView()
    }
}
