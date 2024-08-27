//
//  CreateRecipeScreen.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/22.
//

import SwiftUI

struct CreateRecipeScreen: View {
    @State private var currentSegment: CreateRecipeSegement = .recipeInfo
    @State private var editRecipeInfoModel: EditRecipeInfoScreenModel = .init()
    @State private var viewSize: CGSize = .init(width: 299, height: 300)
    
    var body: some View {
        VStack {
            Header
            
            Picker(selection: $currentSegment, label: Text("test")) {
                HStack {
                    Text("食譜資訊")
                        .foregroundStyle(editRecipeInfoModel.isDone ? Color.green : Color.black)
                }
                .tag(CreateRecipeSegement.recipeInfo)
                Text("所需食材").tag(CreateRecipeSegement.steps)
                Text("烹飪步驟").tag(CreateRecipeSegement.ingredients)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, Spacing.m)
            
            TabView(selection: $currentSegment){
                EditRecipeInfoScreen(viewModel: $editRecipeInfoModel)
                    .readSize($viewSize)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .tag(CreateRecipeSegement.recipeInfo)
                Text("所需食材")
                    .readSize($viewSize)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .tag(CreateRecipeSegement.steps)
                Text("烹飪步驟")
                    .readSize($viewSize)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .tag(CreateRecipeSegement.ingredients)
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
        print("navigate back")
    }
    
    private func onCreate() {
        
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
    CreateRecipeScreen()
        .modelContainer(ModelContainerService.previewModelContainer)
}
