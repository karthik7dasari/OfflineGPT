//
//  ContentView.swift
//  OfflineGPT
//
//  Created by Karthik Dasari on 7/12/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        VStack(spacing: 8) {
                            // Show full chat history
                            ForEach(viewModel.messages) { msg in
                                HStack {
                                    if msg.role == "user" {
                                        Spacer()
                                        Text(msg.content)
                                            .padding()
                                            .background(.ultraThinMaterial.opacity(0.6))
                                            .cornerRadius(10)
                                            .fixedSize(horizontal: false, vertical: true)
                                    } else {
                                        Text(msg.content)
                                            .padding()
                                            .background(.ultraThinMaterial.opacity(0.6))
                                            .cornerRadius(10)
                                            .fixedSize(horizontal: false, vertical: true)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                                .id(msg.id)
                            }

                            // Show currently streaming text
                            if !viewModel.currentStreamingText.isEmpty {
                                HStack {
                                    Text(viewModel.currentStreamingText)
                                        .padding()
                                        .background(.ultraThinMaterial.opacity(0.6))
                                        .cornerRadius(10)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .id("streaming")
                            }

                            // Optional loading dots
                            if viewModel.isLoading && viewModel.currentStreamingText.isEmpty {
                                HStack {
                                    LoadingDotsView()
                                        .padding()
                                        .background(.ultraThinMaterial.opacity(0.6))
                                        .cornerRadius(10)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .id("loading")
                            }
                        }
                        .padding(.vertical)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .onReceive(NotificationCenter.default.publisher(for: .autoScrollTrigger)) { _ in
                        scrollToBottom(scrollProxy: scrollProxy)
                    }
                    .onAppear {
                        scrollToBottom(scrollProxy: scrollProxy)
                    }
                }

                Divider()

                HStack(spacing: 10) {
                    TextField("Ask something...", text: $viewModel.userInput)
                        .padding()
                        .background(.ultraThinMaterial.opacity(0.6))
                        .clipShape(Capsule())
                        .disabled(viewModel.isLoading)

                    Button(action: {
                        Task {
                            await viewModel.send()
                        }
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                            .frame(width: 40, height: 40)
                            //.background(.ultraThinMaterial.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .disabled(viewModel.isLoading || viewModel.userInput.isEmpty)
                    .buttonStyle(.glass)
                }
                .padding()
            }
            .navigationTitle("Local GPT")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Local GPT")
                        .font(.headline)
                }
            }
        }
    }

    private func scrollToBottom(scrollProxy: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(.easeOut(duration: 0.25)) {
                if !viewModel.currentStreamingText.isEmpty {
                    scrollProxy.scrollTo("streaming", anchor: .bottom)
                } else if let lastMsg = viewModel.messages.last {
                    scrollProxy.scrollTo(lastMsg.id, anchor: .bottom)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
