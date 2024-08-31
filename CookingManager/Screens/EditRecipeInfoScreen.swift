//
//  EditRecipeInfoScreen.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/22.
//

import SwiftUI
import SwiftData

@Observable
final class EditRecipeInfoScreenModel {
    var name: String
    var description: String
    var cookingTime: TimeInterval
    var category: RecipeCategory?
    var tags: [Tag] = []

    init(
        name: String = "",
        description: String = "",
        cookingTime: TimeInterval = 0,
        category: RecipeCategory? = nil,
        tags: [Tag] = []
    ) {
        self.name = name
        self.description = description
        self.cookingTime = cookingTime
        self.category = category
        self.tags = tags
    }

    var isDone: Bool {
        !(name.isEmpty || category == nil || cookingTime == 0)
    }
    
    func addTags(tagText: String, tags: [Tag], dataHandler: RecipeDataHandler) async throws {
        guard !tagText.isEmpty else { return }
        guard !self.tags.contains(where: { $0.name == tagText }) else { return }
        
        if let tag = tags.first(where: { $0.name == tagText }) {
            self.tags.append(tag)
        } else {
            let newTag = try await dataHandler.createTag(tagName: tagText)
            self.tags.append(newTag)
        }
    }
}

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
            focusField: .name,
            text: $viewModel.name
        )
    }
    
    @ViewBuilder
    private var DescriptionField: some View {
        makeTextField(
            name: "食譜說明:",
            focusField: .description,
            text: $viewModel.description
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
        focusField: FocusedField,
        text: Binding<String>
    ) -> some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(name)
                .font(.system(size: 14))
            
            TextField("輸入\(name)...", text: text)
                .focused($focus, equals: focusField)
                .font(.system(size: 14))
                .padding(Spacing.s)
                .overlay {
                    let isFocus = focus == focusField
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isFocus ? .blue : .gray, lineWidth: 1)
                }
                .animation(.bouncy, value: focus)
        }
    }
}

//MARK: handlers
extension EditRecipeInfoScreen {
    private func addTags() {
        Task.detached {
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
    enum FocusedField: Hashable{
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
