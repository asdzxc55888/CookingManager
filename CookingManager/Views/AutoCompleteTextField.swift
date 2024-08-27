//
//  AutoCompleteTextField.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/27.
//

import SwiftUI

struct AutoCompleteTextField: View {
    let suggestions: [String]
    @Binding var text: String
    @Binding var showSuggestion: Bool
    @FocusState private var isFocus
    @State private var textFieldSize: CGSize = .init()
    
    init(text: Binding<String>, showSuggestion: Binding<Bool>, suggestions: [String]) {
        self._text = text
        self._showSuggestion = showSuggestion
        self.suggestions = suggestions
    }
    
    var body: some View {
        TextField("Text", text: $text)
            .textFieldStyle(.plain)
            .font(.system(size: 14))
            .focused($isFocus)
            .padding(Spacing.s)
            .readSize($textFieldSize)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isFocus ? .blue : .gray, lineWidth: 1)
            }
            .onChange(of: text) { oldValue, newValue in
                showSuggestion = true
            }
            .overlay {
                SuggestionsList
                    .animation(.bouncy, value: showSuggestion)
                    .animation(.bouncy, value: text)
                    .position(x: textFieldSize.width / 2, y: textFieldSize.height)
                    .offset(y: 51)
            }
    }
    
    @ViewBuilder
    private var SuggestionsList: some View {
        if showSuggestion && !text.isEmpty {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: Spacing.xxs) {
                    let filtedSuggestions = suggestions.filter({ $0.localizedCaseInsensitiveContains(text)
                    })
                    ForEach(filtedSuggestions, id: \.self) { suggestion in
                        makeSuggestionOption(suggestion: suggestion)
                    }
                }
            }
            .frame(height: 100)
            .background {
                RoundedCorner(radius: 16, cornerns: [.bottomLeft, .bottomRight])
                    .fill(Color.white)
                    .stroke(Color.gray.opacity(0.2))
            }
            .padding(.horizontal, Spacing.l)
        }
    }
    
    @ViewBuilder
    private func makeSuggestionOption(suggestion: String) -> some View {
        Button(
            action: {
                text = suggestion
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                    showSuggestion = false
                }
            },
            label: {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(suggestion)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.black)
                        .padding(.horizontal, Spacing.xs)
                        .padding(.vertical, Spacing.xxs)
                    
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                        .opacity(0.2)
                }
                .padding(.horizontal, Spacing.s)
            }
        )
    }
}

private struct PreviewWrapper: View {
    @State private var text: String = ""
    @State private var showSuggestion: Bool = false
    
    var body: some View {
        VStack {
            AutoCompleteTextField(
                text: $text,
                showSuggestion: $showSuggestion,
                suggestions: ["Apple", "Banana", "Cat", "Dog"]
            )
            .zIndex(1)
            
            Text("Some component")
        }
    }
}

#Preview {
    PreviewWrapper()
}
