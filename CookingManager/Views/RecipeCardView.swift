//
//  RecipeCardView.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/15.
//

import SwiftUI
import SwiftData

struct RecipeCardView: View {
    private let index: Int
    private let recipeId: UUID
    private let actionIcon: String?
    private let onPress: (() -> Void)?
    @Query private var recipes: [Recipe]
    
    init(
        index: Int,
        recipeId: UUID,
        actionIcon: String? = nil,
        onPress: (() -> Void)? = nil
    ) {
        self.index = index
        self.recipeId = recipeId
        self.actionIcon = actionIcon
        self.onPress = onPress
    }
    
    private var color: Color {
        RecipeCardColor.allCases[bound: index].color
    }
    
    private var recipe: Recipe? {
        recipes.first(where: { $0.id == recipeId })
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            CardShape
            
            HStack {
                Spacer()
                ActionButton
            }
            
            HStack {
                RecipeInfo
                
                Spacer()
            }
            .padding(Spacing.m)
        }
    }
    
    @ViewBuilder
    private var CardShape: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(color, lineWidth: 2)
                .overlay{
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black.opacity(0.2), lineWidth: 1)
                }
            
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.7))
                .shadow(radius: 1, x: -2, y: 4)
                .overlay {
                    LinearGradient(
                        colors: [
                            Color.white,
                            Color.black.opacity(0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .opacity(0.6)
                .background{
                    RecipeImage
                }
        }
    }
    
    @ViewBuilder
    private var RecipeImage: some View {
        //if let previewImage = recipe?.previewImage,
        //   let uiImage = UIImage(data: previewImage) {
        //    Image(uiImage: uiImage)
        //}
        Image("SampleRecipeImage_2")
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fill)
            .frame(width: 350, height: 96)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    @ViewBuilder
    private var RecipeInfo: some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            HStack(spacing: Spacing.xs) {
                Text(recipe?.name ?? "")
                    .font(.system(size: 17))
                
                Text(recipe?.category.rawValue ?? "")
                    .font(.system(size: 14))
            }
            
            HStack(spacing: Spacing.s) {
                Image(systemName: "frying.pan.fill")
                    .imageScale(.small)
                    .font(.system(size: 14))
                
                Text("烹飪時長：20分鐘")
                    .font(.system(size: 12))
            }
            
            TagsRow
            
        }
        .foregroundStyle(CustomColor.darkGray)
    }
    
    @ViewBuilder
    private var ActionButton: some View {
        if let actionIcon, let onPress {
            Button(
                action: onPress,
                label: {
                    ZStack {
                        Rectangle()
                            .fill(color)
                            .frame(width: 40, height: 28)
                            .cornerRadius(16, corners: [.bottomLeft, .topRight])
                        
                        Image(systemName: actionIcon)
                            .foregroundStyle(Color.white)
                    }
                    .shadow(radius: 2, x: -1, y: 1)
                }
            )
        }
    }
    
    @ViewBuilder
    private var TagsRow: some View {
        HStack {
            let tags = recipe?.tags ?? []
            ForEach(tags, id: \.name) { tag in
                TagView(tag: tag)
            }
        }
    }
}

#Preview {
    VStack(spacing: Spacing.xxl) {
        ForEach(0...4, id: \.self) { index in
            RecipeCardView(
                index: index,
                recipeId: Recipe.mock.id,
                actionIcon: "plus.circle.fill",
                onPress: {
                    print("onPress action button!")
                }
            )
            .frame(width: 350, height: 96)
        }
    }
    .modelContainer(DataProvider.shared.previewModelContainer)
}
