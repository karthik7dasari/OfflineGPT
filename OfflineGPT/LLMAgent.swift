//
//  LLMAgent.swift
//  FoundationModelsPractice
//
//  Created by Karthik Dasari on 7/6/25.
//

import FoundationModels

//class LLMAgent {
//    private let model = LanguageModelSession()
//
//
//    func sendMessage(prompt: String) async throws -> String {
//        let response = try await model.respond(to: prompt)
//        return response.content
//    }
//}



import Foundation
import FoundationModels // iOS 18+, Xcode 16+

class LLMAgent {
    private let session = LanguageModelSession()

    func streamMessage(prompt: String, onToken: @escaping (String) -> Void) async throws {
        let stream = session.streamResponse(to: .init(prompt))
        for try await token in stream {
            onToken(token) // token is the chunk of text
        }
    }

    func sendMessage(prompt: String) async throws -> String {
        let response = try await session.respond(to: .init(prompt))
        return response.content
    }
}
