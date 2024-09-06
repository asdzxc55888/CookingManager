//
//  RecipeListScreen.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/21.
//

import SwiftUI
import SwiftData

struct RecipeListScreen: View {
    @Environment(Navigator.self) var navigator
    
    @State private var selectedCategory: RecipeCategory = .mainCourse
    @State private var selectedDate: Date = .now
    @Query private var recipes: [Recipe]
    
    var body: some View {
        ZStack(alignment: .top) {
            Header
                .zIndex(10)
            
            ScrollView {
                LazyVStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 168)
                    ForEach(recipes.indices, id: \.self) { recipeIndex in
                        let recipe = recipes[recipeIndex]
                        RecipeCardView(
                            index: recipeIndex,
                            recipeId: recipe.id,
                            actionIcon: "plus",
                            onPress: addToSchedule
                        )
                        .padding(.horizontal, Spacing.m)
                        .onTapGesture(perform: {
                            editRecipe(recipeId: recipe.id)
                        })
                    }
                }
            }
        }
        .overlay(alignment: .bottomTrailing, content: {
            CreateRecipeButton
                .padding()
        })
    }
    
    @ViewBuilder
    private var Header: some View {
        VStack(spacing: Spacing.s) {
            Text("食譜")
                .font(.system(size: 17, weight: .medium))
            
            Rectangle()
                .fill(Color.black.opacity(0.15))
                .frame(height: 1)
            
            RecipeCategoryRowView(selectedCategory: $selectedCategory)
                .shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 2)
                .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
            
            DatePickerRow(selectedDate: $selectedDate)
        }
        .padding(.vertical, Spacing.s)
        .background {
            RoundedCorner(radius: 32, cornerns: [.bottomLeft, .bottomRight])
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                .ignoresSafeArea()
        }
        .frame(height: 160)
    }
    
    @ViewBuilder
    private var CreateRecipeButton: some View {
        Button(action: navigateCreateRecipe, label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundStyle(CustomColor.darkSkyBlue)
        })
    }
}

//MARK: handler
extension RecipeListScreen {
    private func addToSchedule() {
        //TODO: need implement
        print("onPress: addToSchedule")
    }
    
    private func editRecipe(recipeId: UUID) {
        //TODO: need implement
        print("onPress: editRecipe, with id:\(recipeId)")
    }
    
    private func navigateCreateRecipe() {
        navigator.push(route: .createRecipe(onBack: {
            navigator.pop()
        }))
    }
}

#Preview {
    RecipeListScreen()
        .environment(Navigator())
        .modelContainer(ModelContainerService.previewModelContainer)
}
