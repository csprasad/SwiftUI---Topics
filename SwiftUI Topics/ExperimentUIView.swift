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

    var body: some View {
        VStack {
            Button(action: {
                showBottomSheet.toggle()
            }) {
                Text(selectedValue ?? "Select an item")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $showBottomSheet) {
            GeometryReader { geometry in
                BottomSheetView(selectedValue: $selectedValue)
                    .frame(width: geometry.size.width, height: geometry.size.height / 2)
                    .background(Color.white) // Or any other background color
                    .cornerRadius(20) // For rounded corners
                    .offset(y: geometry.size.height / 2) // Adjust position
                    .shadow(radius: 10) // Optional shadow
            }
        }

    }
}

struct BottomSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedValue: String?

    let items = [
        ("Jarrod Lindgren", "Direct Security Developer"),
        ("Johnnie Steuber", "Internal Response Engineer"),
        ("Adolph Ankunding", "Future Solutions Assistant"),
        ("Donald Gusikowski", "Customer Intranet Liaison"),
        ("Fatima Weber", "Internal Security Designer")
    ]

    var body: some View {
        ZStack {

            VStack {
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)

                Text("Select Blend Mode")
                    .font(.headline)
                    .padding(.vertical)

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
            .shadow(radius: 10)
        }
    }
}


struct ExperimentUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentUIView()
    }
}
