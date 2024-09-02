//
//  EditRecipeStepScreen.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/9/1.
//

import SwiftUI

@Observable
final class EditRecipeStepScreenModel {
    struct CookingStep {
        var text: String
        var image: Data?
    }
    
    var cookingSteps: [EditCookingStepCell.CookingStep] = [
        .init(text: "")
    ]
    
    var showDeleteButton: Bool {
        cookingSteps.count > 1
    }
    
    func addNewCookingStep() {
        cookingSteps.append(.init(text: ""))
    }
    
    func deleteCookingStep(at index: Int) {
        guard index < cookingSteps.count else { return }
        cookingSteps.remove(at: index)
    }
}

struct EditRecipeStepScreen: View {
    @Environment(\.dataProvider) var dataProvider
    @Binding var viewModel: EditRecipeStepScreenModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.cookingSteps.indices, id:\.self) { index in
                    EditCookingStepCell(
                        index: index,
                        cookingStep: $viewModel.cookingSteps[index],
                        onDelete: viewModel.showDeleteButton ? {
                            viewModel.deleteCookingStep(at: index)
                        } : nil
                    )
                        .padding(Spacing.s)
                }
                
                AddStepButton
            }
        }
    }
    
    @ViewBuilder
    private var AddStepButton: some View {
        Button(
            action: { viewModel.addNewCookingStep() },
            label: {
                HStack {
                    Text("新增步驟")
                    Image(systemName: "plus.circle.fill")
                }
                .foregroundStyle(CustomColor.darkSkyBlue)
            }
        )
    }
}

private struct PreviewWrapper: View {
    @State private var viewModel: EditRecipeStepScreenModel = .init()
    
    var body: some View {
        EditRecipeStepScreen(viewModel: $viewModel)
            .modelContainer(DataProvider.shared.previewModelContainer)
    }
}

#Preview {
    PreviewWrapper()
}
