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
import OpenAI

class ContentViewModel: ObservableObject {
    @Published var pickerItem: PhotosPickerItem?
    @Published var pickerImage: Image?
    @Published var isRecognizingText: Bool = false
    @Published var recognizedText: String?
    @Published var isShowingCardView: Bool = false
    @Published var flashcards: [Flashcard] = []
    
    private let openAi = OpenAI(apiToken: "my_dummy_api_key")
    
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
        
        if let text = recognizedText {
            await sendContextToChatGPT(text)
            isRecognizingText = false
            isShowingCardView = true
        }
    }
    
    private func recognizeText(from uiImage: UIImage) {
        print("now the recognizeText(from uiImage:) called!")
        
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
        print("now the recognizeTextHandler(request:, error:) called!")
        
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            isRecognizingText = false
            return
        }
        
        let recognizedStrings = observations.compactMap { observation in
            return observation.topCandidates(1).first?.string
        }
        
        print(recognizedStrings)
        recognizedText = recognizedStrings.joined(separator: ", ")
        
    }
    
    private func sendContextToChatGPT(_ context: String) async {
        print("now the sendContextToChatGPT(_ context:) called!")
        
        do {
            // create query element
            let query = CreateModelResponseQuery(
                input: .textInput("You are a personalized educational tutor. Your task is to generate 25 high-quality flashcards based on keywords extracted from a user's handwritten notes. These keywords may contain typos, so you should infer the correct terms and identify the subject area they relate to. Your flashcards must: Be written in a friendly, approachable tone (no emojis), Be informative and accurate, Clearly explain the concept in a way that helps someone learning it for the first time, Be phrased as question → answer pairs (like real flashcards), Focus on the most important concepts related to the subject, Avoid unnecessary jargon where possible, or explain it simply, Be helpful even if the user is a beginner. Use the provided keywords to determine the topic, then generate flashcards that best support understanding of that topic. Here are the keywords recognized from the user’s notebook: \(context)"),
                model: .gpt4_1_mini,
                text: .jsonSchema(
                    .init(name: "flashcard", schema: .derivedJsonSchema(FlashcardsJsonScheme.self), description: nil, strict: true)
                )
            )
            
            // get response response
            let result = try await openAi.responses.createResponse(query: query)
            
            // extract the output text
            for output in result.output {
                switch output {
                case .outputMessage(let outputMessage):
                    for content in outputMessage.content {
                        switch content {
                        case .OutputTextContent(let textContent):
                            print(textContent.text)
                            if let parsed = FlashcardParser.parse(jsonString: textContent.text) {
                                flashcards = parsed.flashcards
                            }
                            
                        case .RefusalContent(let refusalContent):
                            print(refusalContent.refusal)
                        }
                    }
                default:
                    print("Error handling the response.")
                }
            }
        } catch {
            print("Error creating the response.")
        }
    }
}
