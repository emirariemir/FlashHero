//
//  ContentView.swift
//  FlashHero
//
//  Created by Emir Arı on 5.11.2025.
//

import SwiftUI
import PhotosUI
import Vision

struct ContentView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var pickerUiImage: UIImage?
    @State private var pickerImage: Image?
    
    @State private var isRecognizingText: Bool = false
    @State private var recognizedText: String?
    
    var body: some View {
        ZStack {
            VStack {
                PhotosPicker("Select photo", selection: $pickerItem, matching: .images)
                
                pickerImage?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 300)
                
                if let rText = recognizedText {
                    Text(rText)
                        .font(.footnote)
                }
            }
            .onChange(of: pickerItem) {
                Task {
                    isRecognizingText = true
                    
                    if let loadedImageData = try? await pickerItem?.loadTransferable(type: Data.self) {
                        pickerUiImage = UIImage(data: loadedImageData)
                        pickerImage = Image(uiImage: pickerUiImage!)
                        recognizeText(from: pickerUiImage!)
                    } else {
                        print("Failed to download image.")
                    }
                }
            }
            
            if isRecognizingText {
                Rectangle()
                    .fill()
                    .opacity(0.3)
                    .ignoresSafeArea()
                
                ProgressView()
            }
        }
    }
    
    func recognizeText(from uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else { return }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }
    
    func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            return
        }
        
        let recognizedStrings = observations.compactMap { observation in
            return observation.topCandidates(1).first?.string
        }
        
        print(recognizedStrings)
        recognizedText = recognizedStrings.joined(separator: ", ")
        
        isRecognizingText = false
    }
}

#Preview {
    ContentView()
}
