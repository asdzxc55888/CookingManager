//
//  CreateRecipeScreen.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/22.
//

import SwiftUI

struct CreateRecipeScreen: View {
    @Environment(\.dataProvider) var dataProvider
    
    let onBack: () -> Void
    
    @State private var currentSegment: CreateRecipeSegement = .recipeInfo
    @State private var editRecipeInfoModel: EditRecipeInfoScreenModel = .init()
    @State private var editRecipeStepModel: EditRecipeStepScreenModel = .init()
    @State private var editIngredientsModel: EditIngredientsScreenModel = .init()
    @State private var viewSize: CGSize = .init(width: 299, height: 300)
    
    var body: some View {
        VStack {
            Header
            
            Picker(selection: $currentSegment, label: Text("test")) {
                Text("食譜資訊").tag(CreateRecipeSegement.recipeInfo)
                Text("所需食材").tag(CreateRecipeSegement.ingredients)
                Text("烹飪步驟").tag(CreateRecipeSegement.steps)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, Spacing.m)
            
            TabView(selection: $currentSegment){
                EditRecipeInfoScreen(viewModel: $editRecipeInfoModel)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .tag(CreateRecipeSegement.recipeInfo)
                EditIngredientsScreen(viewModel: $editIngredientsModel)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .tag(CreateRecipeSegement.ingredients)
                EditRecipeStepScreen(viewModel: $editRecipeStepModel)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .tag(CreateRecipeSegement.steps)
            }
            .tabViewStyle(.page)
            .padding(Spacing.l)
        }
    }
    
    @ViewBuilder
    private var Header: some View {
        HStack {
            Button(
                action: onNavigateBack,
                label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(Color.black)
                }
            )
            .padding(.horizontal, Spacing.m)
            
            Spacer()
            
            Button(
                action: onCreate,
                label: {
                    Text("創建")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.white)
                        .padding(.vertical, Spacing.xs)
                        .padding(.horizontal, Spacing.m)
                        .background(CustomColor.darkSkyBlue)
                        .cornerRadius(8, corners: .allCorners)
                }
            )
        }
        .padding(.vertical, Spacing.s)
        .padding(.horizontal, Spacing.m)
        .overlay{
            Text("新增食譜")
        }
    }
}

//MARK: handler
extension CreateRecipeScreen {
    private func onNavigateBack() {
        onBack()
    }
    
    private func isValid() -> Bool {
        let isRecipeInfoValid = editRecipeInfoModel.validate()
        let isCookingStepsValid = editRecipeStepModel.validate()
        
        if !isRecipeInfoValid {
            currentSegment = .recipeInfo
        } else if !isCookingStepsValid {
            currentSegment = .steps
        }
        
        return isRecipeInfoValid && isCookingStepsValid
    }
    
    private func onCreate() {
        guard isValid() else { return }
        guard let category = editRecipeInfoModel.category else { return }
        
        Task {
            let dataHandlerCreator = dataProvider.dataHandlerCreator(for: RecipeDataHandler.self)
            let dataHandler = await dataHandlerCreator()
            _ = try await dataHandler.createRecipe(dto:
                .init(
                    name: editRecipeInfoModel.name.text,
                    recipeDesc: editRecipeInfoModel.description.text,
                    cookingTime: editRecipeInfoModel.cookingTime,
                    ingredients: editIngredientsModel.ingredients.map { ingredient in
                        IngredientInfo(
                            ingredient: .init(
                                name: ingredient.ingredientName.text,
                                quantifier: ingredient.ingredientQuantifier.text
                            ),
                            number: ingredient.number
                        )
                    },
                    cookingStep: editRecipeStepModel.cookingSteps.map { step in
                        CookingStep(
                            text: step.textField.text,
                            image: step.image
                        )
                    },
                    tags: editRecipeInfoModel.tags,
                    category: category
                )
            )
        }
    }
}

extension CreateRecipeScreen {
    enum CreateRecipeSegement: Hashable {
        case recipeInfo
        case steps
        case ingredients
    }
}

#Preview {
    CreateRecipeScreen(onBack: {})
        .modelContainer(ModelContainerService.previewModelContainer)
}
