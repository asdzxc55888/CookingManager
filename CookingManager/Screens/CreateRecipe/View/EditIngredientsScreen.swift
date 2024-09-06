//
//  EditIngredientsScreen.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/28.
//

import SwiftUI
import SwiftData

struct EditIngredientsScreen: View {
    @Binding var viewModel: EditIngredientsScreenModel
    @Query private var existIngredients: [Ingredient]
    
    var body: some View {
        VStack {
            HStack {
                Text("新增食材")
                Spacer()
                Button(
                    action: viewModel.addIngredients,
                    label: {
                        Image(systemName: "plus.circle")
                    }
                )
            }
            
            IngredientsList
        }
        .padding(.horizontal, Spacing.m)
    }
    
    @ViewBuilder
    private var IngredientsList: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.ingredients.indices, id: \.self) { index in
                    HStack(alignment: .bottom) {
                        CustomTextField(fieldModel: $viewModel.ingredients[index].ingredientName)
                        TextField(
                            "數量",
                            value: $viewModel.ingredients[index].number,
                            formatter:  NumberFormatter()
                        )
                        .textFieldStyle(.roundedBorder)
                        CustomTextField(fieldModel: $viewModel.ingredients[index].ingredientQuantifier)
                    }
                }
            }
        }
    }
}

private struct PreviewWrapper: View {
    @State private var viewModel: EditIngredientsScreenModel = .init()
    
    var body: some View {
        EditIngredientsScreen(
            viewModel: $viewModel
        )
        .modelContainer(ModelContainerService.previewModelContainer)
    }
}

#Preview {
    PreviewWrapper()
}
