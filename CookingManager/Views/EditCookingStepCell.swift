//
//  EditCookingStepCell.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/9/1.
//

import SwiftUI
import PhotosUI

struct EditCookingStepCell: View {
    let index: Int
    let onDelete: (() -> Void)?
    @Binding var cookingStep: CookingStep
    @State private var selectedItem: PhotosPickerItem? = nil
    
    init(index: Int, cookingStep: Binding<CookingStep>, onDelete: (() -> Void)?) {
        self.index = index
        self._cookingStep = cookingStep
        self.onDelete = onDelete
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Step \(String(index + 1))")
                    .font(.system(size: 17, weight: .bold))
                Spacer()
                DeleteStepButton
            }
        
            TextField("輸入烹飪步驟...", text: $cookingStep.text, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            
            if let imageData = cookingStep.image, let uiImage = UIImage(data: imageData) {
                HStack {
                    Spacer()
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                    Spacer()
                }
            } else {
                ImagePickerButton
            }
        }
        .padding(Spacing.m)
        .background(CustomColor.lightGray.opacity(0.3))
        .cornerRadius(16, corners: .allCorners)
    }
    
    @ViewBuilder
    private var DeleteStepButton: some View {
        if let onDelete {
            Button(
                action: onDelete,
                label: {
                    Image(systemName: "minus.circle")
                        .foregroundStyle(Color.red)
                }
            )
        }
    }
    
    @ViewBuilder
    private var ImagePickerButton: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            HStack {
                Spacer()
                Text("添加圖片")
                    .font(.system(size: 17, weight: .bold))
                Image(systemName: "photo.badge.plus")
                    .imageScale(.large)
                    .frame(width: 40, height: 40)
                Spacer()
            }
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(CustomColor.darkSkyBlue, lineWidth: 2)
            }
            .foregroundStyle(CustomColor.darkSkyBlue)
        }
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    cookingStep.image = data
                }
            }
        }
    }
}

extension EditCookingStepCell {
    struct CookingStep {
        var text: String
        var image: Data?
    }
}

private struct PreviewWrapper: View {
    @State private var cookingStep: EditCookingStepCell.CookingStep = .init(text: "")
    
    var body: some View {
        EditCookingStepCell(index: 0, cookingStep: $cookingStep, onDelete: {})
    }
}

#Preview {
    PreviewWrapper()
}
