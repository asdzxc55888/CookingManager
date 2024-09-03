//
//  EditIngredientsScreen.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/28.
//

import SwiftUI
import SwiftData

struct EditIngredientsScreen: View {
    @Binding var ingredients: [IngredientProps]
    @Query private var existIngredients: [Ingredient]
    
    var body: some View {
        VStack {
            HStack {
                Text("新增食材")
                Spacer()
                Button(
                    action: addIngredients,
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
                ForEach(ingredients.indices, id: \.self) { index in
                    HStack {
                        TextField(
                            "食材名稱",
                            text: $ingredients[index].ingredientName
                        )
                        TextField(
                            "數量",
                            value: $ingredients[index].number,
                            formatter:  NumberFormatter()
                        )
                        TextField("單位", text: $ingredients[index].ingredientQuantifier)
                    }
                }
            }
        }
    }
}

//MARK: handler
extension EditIngredientsScreen {
    private func addIngredients() {
        ingredients.append(
            .init(
                ingredientName: "",
                ingredientQuantifier: "",
                number: 0
            )
        )
    }
}

extension EditIngredientsScreen {
    struct IngredientProps: Equatable, Identifiable {
        let id: UUID = .init()
        var ingredientName: String
        var ingredientQuantifier: String
        var number: Int
    }
}

private struct PreviewWrapper: View {
    @State private var ingredients: [EditIngredientsScreen.IngredientProps] = []
    
    var body: some View {
        EditIngredientsScreen(
            ingredients: $ingredients
        )
        .modelContainer(ModelContainerService.previewModelContainer)
    }
}

#Preview {
    PreviewWrapper()
}
