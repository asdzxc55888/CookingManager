//
//  RecipeCategoryRowView.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/20.
//

import SwiftUI

struct RecipeCategoryRowView: View {
    @Binding var selectedCategory: RecipeCategory
    @State private var scrollProxy: ScrollViewProxy? = nil
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(RecipeCategory.allCases, id: \.hashValue) { category in
                        //MARK: reserve some space for the auto scroll
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 8, height: 1)
                            .id(category.hashValue)
                        
                        makeCategory(category: category)
                    }
                }
            }
            .onAppear {
                scrollProxy = proxy
            }
        }
    }
    
    @ViewBuilder
    private func makeCategory(category: RecipeCategory) -> some View {
        let isSelected = selectedCategory == category
        let backgroundColor = isSelected ? CustomColor.darkSkyBlue : Color.white
        let textColor = isSelected ? Color.white : Color.black
        
        Button(
            action: { onPressCategort(category: category) },
            label: {
                Text(category.rawValue)
                    .font(.system(size: 14))
                    .foregroundStyle(textColor)
                    .padding(Spacing.s)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(backgroundColor)
                            .frame(minHeight: 30)
                    }
            }
        )
        .animation(.bouncy(duration: 1), value: selectedCategory)
    }
}

//MARK: handler
extension RecipeCategoryRowView {
    private func onPressCategort(category: RecipeCategory) {
        selectedCategory = category
        
        withAnimation {
            scrollProxy?.scrollTo(category.hashValue, anchor: .leading)
        }
    }
}

private struct PreviewWrapper: View {
    @State private var selectedCategory: RecipeCategory = .mainCourse
    
    var body: some View {
        RecipeCategoryRowView(selectedCategory: $selectedCategory)
            .background(Color.gray)
    }
}

#Preview {
    PreviewWrapper()
}
