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
    
    var body: some View {
        VStack {
            PhotosPicker("Select photo", selection: $pickerItem, matching: .images)
            
            pickerImage?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 300)
        }
        .onChange(of: pickerItem) {
            Task {
                if let loadedImageData = try? await pickerItem?.loadTransferable(type: Data.self) {
                    pickerUiImage = UIImage(data: loadedImageData)
                    pickerImage = Image(uiImage: pickerUiImage!)
                    
                    recognizeText(from: pickerUiImage!)
                } else {
                    print("Failed to download image.")
                }
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
    }
}

#Preview {
    ContentView()
}
