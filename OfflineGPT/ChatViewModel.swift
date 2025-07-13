//
//  ChatViewModel.swift
//  FoundationModelsPractice
//
//  Created by Karthik Dasari on 7/6/25.
//

import SwiftUI
import Combine
import Foundation

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var userInput: String = ""
    @Published var isLoading = false
    @Published var currentStreamingText: String = ""

    private var agent: LLMAgent?

    init() {
        self.agent = LLMAgent()
    }

    func send() async {
        let prompt = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !prompt.isEmpty else { return }

        // Append user's message
        messages.append(ChatMessage(role: "user", content: prompt))
        userInput = ""
        isLoading = true
        currentStreamingText = ""

        do {
            try await agent?.streamMessage(prompt: prompt) { token in
                Task { @MainActor in
                    self.currentStreamingText = token
                    NotificationCenter.default.post(name: .autoScrollTrigger, object: nil)
                }
            }

            // When streaming completes, add assistant's full message
            messages.append(ChatMessage(role: "assistant", content: currentStreamingText))
            currentStreamingText = ""
        } catch {
            messages.append(ChatMessage(role: "assistant", content: "Agent error: \(error.localizedDescription)"))
        }

        isLoading = false
    }
}


