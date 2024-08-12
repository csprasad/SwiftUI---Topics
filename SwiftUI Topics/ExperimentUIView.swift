//
//  ExperimentUIView.swift
//  SwiftUI Topics
//
//  Created by CS Prasad on 10/08/24.
//

import SwiftUI

struct ExperimentUIView: View {
    @State private var showBottomSheet = false
    @State private var selectedValue: String?
    
    @State private var showingCredits = false


    var body: some View {
        VStack {
            Button("Show Credits") {
                showingCredits.toggle()
            }
            .sheet(isPresented: $showingCredits) {
                BottomSheet(selectedValue: $selectedValue)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }

    }
}

struct BottomSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedValue: String?

    let items = [
        ("Jarrod Lindgren", "Direct Security Developer"),
        ("Johnnie Steuber", "Internal Response Engineer"),
        ("Adolph Ankunding", "Future Solutions Assistant"),
        ("Donald Gusikowski", "Customer Intranet Liaison"),
        ("Fatima Weber", "Internal Security Designer"),
        ("Jarrod Lindgren", "Direct Security Developer"),
        ("Johnnie Steuber", "Internal Response Engineer"),
        ("Adolph Ankunding", "Future Solutions Assistant"),
        ("Donald Gusikowski", "Customer Intranet Liaison"),
        ("Fatima Weber", "Internal Security Designer"),
        ("Jarrod Lindgren", "Direct Security Developer"),
        ("Johnnie Steuber", "Internal Response Engineer"),
        ("Adolph Ankunding", "Future Solutions Assistant"),
        ("Donald Gusikowski", "Customer Intranet Liaison"),
        ("Fatima Weber", "Internal Security Designer")
    ]

    var body: some View {
        ZStack {

            VStack {
                Text("Select Blend Mode")
                    .font(.headline)
                    .padding(.vertical, 20)

                List {
                    ForEach(items.indices, id: \.self) { index in
                        Button(action: {
                            selectedValue = "\(index): \(items[index].0)"
                            dismiss()
                        }) {
                            HStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(width: 5, height: 5)

                                VStack(alignment: .leading) {
//                                    Text("\(index): \(items[index].0)")
//                                        .font(.headline)
                                    Text(items[index].1)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 8)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .listStyle(PlainListStyle())
            }
            .background(Color.white)
            .cornerRadius(20)
//            .shadow(radius: 10)
        }
    }
}


struct ExperimentUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentUIView()
    }
}
