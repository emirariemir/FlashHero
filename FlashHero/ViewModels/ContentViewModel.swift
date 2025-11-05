//
//  ContentViewModel.swift
//  FlashHero
//
//  Created by Emir Arı on 5.11.2025.
//

import SwiftUI
import PhotosUI
import Vision
import Combine

class ContentViewModel: ObservableObject {
    @Published var pickerItem: PhotosPickerItem?
    @Published var pickerImage: Image?
    @Published var isRecognizingText: Bool = false
    @Published var recognizedText: String?
    @Published var isShowingCardView: Bool = false
    
    func handlePickerItemChange() {
        Task {
            await loadAndRecognizeImage()
        }
    }
    
    private func loadAndRecognizeImage() async {
        isRecognizingText = true
        
        guard let loadedImageData = try? await pickerItem?.loadTransferable(type: Data.self) else {
            isRecognizingText = false
            return
        }
        
        guard let uiImage = UIImage(data: loadedImageData) else {
            isRecognizingText = false
            return
        }
        
        pickerImage = Image(uiImage: uiImage)
        recognizeText(from: uiImage)
        
        print("At this point, recognizeText(from:) function is called.")
        isShowingCardView = true
    }
    
    private func recognizeText(from uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else {
            isRecognizingText = false
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
            isRecognizingText = false
        }
    }
    
    private func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            isRecognizingText = false
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
