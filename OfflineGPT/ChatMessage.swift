//
//  ChatMessage.swift
//  FoundationModelsPractice
//
//  Created by Karthik Dasari on 7/6/25.
//

import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: String // "user" or "assistant"
    let content: String
}
