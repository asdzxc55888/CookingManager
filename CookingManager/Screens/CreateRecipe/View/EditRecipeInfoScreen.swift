//
//  EditRecipeInfoScreen.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/22.
//

import SwiftUI
import SwiftData

struct EditRecipeInfoScreen: View {
    @Environment(\.dataProvider) private var dataProvider
    
    @Binding private var viewModel: EditRecipeInfoScreenModel
    @State private var selectedCategort: RecipeCategory? = nil
    @State private var tagText: String = ""
    @State private var showTagsSuggestion: Bool = false
    @FocusState private var focus: FocusedField?
    @Query private var tags: [Tag]
    
    init(viewModel: Binding<EditRecipeInfoScreenModel>) {
        self._viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xl) {
            EditNameField
            DescriptionField
            CookingTimePicker(timeValue: $viewModel.cookingTime)
            CategoryField
            TagsRow
        }
        .padding(.horizontal, Spacing.xs)
    }
    
    @ViewBuilder
    private var EditNameField: some View {
        makeTextField(
            name: "食譜名稱:",
            fieldModel: $viewModel.name
        )
    }
    
    @ViewBuilder
    private var DescriptionField: some View {
        makeTextField(
            name: "食譜說明:",
            fieldModel: $viewModel.description
        )
    }
    
    @ViewBuilder
    private var CategoryField: some View {
        HStack {
            Text("分類:")
                .font(.system(size: 14))
            
            Menu {
                Picker(selection: $viewModel.category) {
                    ForEach(RecipeCategory.allCases.reversed()) { category in
                        Text(category.rawValue)
                            .tag(category as RecipeCategory?)
                    }
                    
                    Text("請選擇食譜分類")
                        .tag(nil as RecipeCategory?)
                } label: {}
            } label: {
                Text(viewModel.category?.rawValue ?? "請選擇食譜分類")
                    .font(.system(size: 14))
                    .foregroundStyle(CustomColor.darkSkyBlue)
            }
            
        }
    }
    
    @ViewBuilder
    private var TagsRow: some View {
        VStack {
            HStack {
                Text("標籤")
                    .font(.system(size: 14))
                
                AutoCompleteTextField(
                    text: $tagText, 
                    showSuggestion: $showTagsSuggestion,
                    suggestions: tags.map{ $0.name }
                )
                
                Button(
                    action: addTags,
                    label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(CustomColor.darkSkyBlue)
                    }
                )
            }
            .zIndex(1)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.tags) { tag in
                        TagView(tag: tag)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func makeTextField(
        name: String,
        fieldModel: Binding<CustomTextFieldModel>
    ) -> some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(name)
                .font(.system(size: 14))
            
            CustomTextField(fieldModel: fieldModel)
        }
    }
}

//MARK: handlers
extension EditRecipeInfoScreen {
    private func addTags() {
        Task {
            let dataHandler = await dataProvider.dataHandlerCreator(for: RecipeDataHandler.self)()
            try await viewModel.addTags(
                tagText: tagText,
                tags: tags,
                dataHandler: dataHandler
            )
            showTagsSuggestion = false
            tagText = ""
        }
    }
}

//MARK: enumration
extension EditRecipeInfoScreen {
    enum FocusedField: Hashable {
        case name
        case description
    }
}

private struct PreviewWrapper: View {
    @State private var viewModel = EditRecipeInfoScreenModel()
    
    var body: some View {
        EditRecipeInfoScreen(viewModel: $viewModel)
            .padding()
            .modelContainer(DataProvider.shared.previewModelContainer)
    }
}

#Preview {
    PreviewWrapper()
}
