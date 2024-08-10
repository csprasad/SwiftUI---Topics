//
//  ExperimentUIView.swift
//  SwiftUI Topics
//
//  Created by CS Prasad on 10/08/24.
//

import SwiftUI

struct ExperimentUIView: View {

    var body: some View {
        ZStack {
            Image("TajMahal")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 300)
            
            Rectangle()
                .fill(Color(red: 15/255, green: 5/255, blue: 56/255, opacity: 1))
                .frame(width: 500, height: 180)
                .rotationEffect(.degrees(-30))
                .offset(x: 0, y: 0)
                .blendMode(.destinationOver)
        }
        .clipped()
        .frame(height: 300)
    }
}


struct ExperimentUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentUIView()
    }
}
