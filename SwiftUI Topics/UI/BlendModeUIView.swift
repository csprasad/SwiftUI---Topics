//
//  SwiftUIView.swift
//  SwiftUI Topics
//
//  Created by CS Prasad on 09/08/24.
//

import SwiftUI
import PhotosUI

private func blendModeName(_ blendMode: BlendMode) -> String {
    let blendModeNames: [BlendMode: String] = [
        .normal: "Normal", .multiply: "Multiply", .screen: "Screen", .overlay: "Overlay",
        .darken: "Darken", .lighten: "Lighten", .colorDodge: "Color Dodge", .colorBurn: "Color Burn",
        .softLight: "Soft Light", .hardLight: "Hard Light", .difference: "Difference", .exclusion: "Exclusion",
        .hue: "Hue", .saturation: "Saturation", .color: "Color", .luminosity: "Luminosity",
        .sourceAtop: "Source Atop", .destinationOver: "Desti.. Over", .destinationOut: "Desti.. Out",
        .plusDarker: "Plus Darker", .plusLighter: "Plus Lighter"
    ]
    return blendModeNames[blendMode] ?? "Unknown"
}

struct BlendModeUIView: View {
    @State private var selectedColor: Color = .red
    @State private var selectedImage: UIImage? = UIImage(named: "TajMahal")
    @State private var isImagePickerPresented = false
    @State private var currentBlendModeIndex = 0

    let blendModes: [BlendMode] = [
        .normal, .multiply, .screen, .overlay, .darken, .lighten, .colorDodge, .colorBurn,
        .softLight, .hardLight, .difference, .exclusion, .hue, .saturation, .color, .luminosity,
        .sourceAtop, .destinationOver, .destinationOut, .plusDarker, .plusLighter
    ]

    var body: some View {
        VStack(spacing: 20) {
            ImageWithOverlay(
                selectedImage: selectedImage,
                selectedColor: selectedColor,
                currentBlendMode: blendModes[currentBlendModeIndex]
            )
            
            ColorPickerAndButton(
                selectedColor: $selectedColor,
                isImagePickerPresented: $isImagePickerPresented
            )
            
            BlendModeButtons(
                blendModes: blendModes,
                blendModeName: blendModeName,
                currentBlendModeIndex: $currentBlendModeIndex
            )
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}



struct ImageWithOverlay: View {
    let selectedImage: UIImage?
    let selectedColor: Color
    let currentBlendMode: BlendMode

    var body: some View {
        ZStack {
            Image(uiImage: selectedImage ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 300)
            
            Rectangle()
                .fill(selectedColor)
                .frame(width: 500, height: 180)
                .rotationEffect(.degrees(-30))
                .offset(x: 0, y: 0)
                .blendMode(currentBlendMode)
        }
        .clipped()
        .frame(height: 300)
    }
}

struct ColorPickerAndButton: View {
    @Binding var selectedColor: Color
    @Binding var isImagePickerPresented: Bool

    var body: some View {
        HStack {
            ColorPicker("", selection: $selectedColor)
                .frame(maxHeight: 50)
                .cornerRadius(8)
                .padding()
            
            Spacer()
            
            Button(action: {
                isImagePickerPresented.toggle()
            }) {
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.orange)
                    .frame(width: 50, height: 50)
            }
            .padding()
        }
        .frame(height: 50)
    }
}

struct BlendModeRow: View {
    let rowIndex: Int
    let blendModes: [BlendMode]
    let blendModeName: (BlendMode) -> String
    @Binding var currentBlendModeIndex: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(rowRange, id: \.self) { columnIndex in
                let index = rowIndex * 3 + columnIndex
                if index < blendModes.count {
                    let blendMode = blendModes[index]
                    let blendModeName = self.blendModeName(blendMode)
                    
                    BlendModeButton(
                        blendMode: blendMode,
                        blendModeName: blendModeName,
                        action: {
                            print("Button \(blendModeName) Pressed")
                            currentBlendModeIndex = index
                        }
                    )
                }
            }
        }
    }

    private var rowRange: Range<Int> {
        0..<3 // Number of columns per row
    }
}

struct BlendModeButton: View {
    let blendMode: BlendMode
    let blendModeName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(blendModeName)
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct BlendModeButtons: View {
    let blendModes: [BlendMode]
    let blendModeName: (BlendMode) -> String
    @Binding var currentBlendModeIndex: Int

    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(0..<numberOfRows, id: \.self) { rowIndex in
                        BlendModeRow(
                            rowIndex: rowIndex,
                            blendModes: blendModes,
                            blendModeName: blendModeName,
                            currentBlendModeIndex: $currentBlendModeIndex
                        )
                    }
                }
            }
        }
        .padding()
    }

    private var numberOfRows: Int {
        (blendModes.count + 2) / 3 // Assuming 3 columns per row
    }
}


// MARK: - Image Picker Integration
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}

struct BlendModeUIView_Previews: PreviewProvider {
    static var previews: some View {
        BlendModeUIView()
    }
}
