//
//  CustomTextField.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/9/4.
//

import SwiftUI

@Observable
final class CustomTextFieldModel {
    var text: String {
        didSet {
            onTextChanged()
        }
    }
    let placeholder: String
    var errorMessage: String?
    private let validation: ((_ text: String) -> String?)?
    
    var showError: Bool = false
    private var debounceTimer: DispatchWorkItem?
    
    init(text: String, placeholder: String = "", validation: ((_ text: String) -> String?)? = nil) {
        self.text = text
        self.placeholder = placeholder
        self.validation = validation
    }
    
    func validate() -> Bool {
        guard let validation else { return true }
        
        let newErrorMessage = validation(self.text)
        let isValid = newErrorMessage == nil
        self.errorMessage  = newErrorMessage
        
        showError = !isValid
        return isValid
    }
    
    private func onTextChanged() {
        debounceTimer?.cancel()
        
        let task = DispatchWorkItem { [weak self] in
            _ = self?.validate()
        }
        debounceTimer = task
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
    }
}

struct CustomTextField: View {
    @Binding var fieldModel: CustomTextFieldModel
    @FocusState var isFocused: Bool
    
    init(fieldModel: Binding<CustomTextFieldModel>) {
        self._fieldModel = fieldModel
    }
    
    private var boardColor: Color {
        if fieldModel.showError {
            return .red
        } else if isFocused {
            return .blue
        } else {
            return .gray
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            TextField(fieldModel.placeholder, text: $fieldModel.text)
                .focused($isFocused)
                .font(.system(size: 16))
                .frame(height: 28)
                .padding(Spacing.s)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(boardColor, lineWidth: 1)
                }
                .animation(.bouncy, value: isFocused)
                .animation(.bouncy, value: fieldModel.showError)
            
            if let errorMessage = fieldModel.errorMessage, fieldModel.showError {
                Text(errorMessage)
                    .font(.system(size: 14))
                    .foregroundStyle(.red)
            }
        }
    }
}

private struct PreviewWrapper: View {
    @State private var fieldModels: [CustomTextFieldModel] = [
        .init(
            text: "",
            placeholder: "輸入文字",
            validation: { text in
                if text.isEmpty {
                    return "請輸入文字"
                }
                return nil
            }
        ),
        .init(text: "", placeholder: "輸入數字", validation: { text in
            let isNumeric = Double(text) != nil
            if !isNumeric {
                return "請輸入數字"
            }
            return nil
        })
    ]
    
    var body: some View {
        VStack(spacing: Spacing.m) {
            ForEach(fieldModels.indices, id:\.self) { index in
                CustomTextField(fieldModel: $fieldModels[index])
            }
            
            Button("Submit") {
                var isValid = true
                fieldModels.forEach { model in
                    isValid = model.validate() && isValid
                }
                print(isValid)
            }
        }
        .padding()
    }
}

#Preview {
    PreviewWrapper()
}
