//
//  EditRecipeInfoScreenModelTests.swift
//  CookingManagerTests
//
//  Created by 何韋辰 on 2024/9/2.
//

import XCTest
@testable import CookingManager

final class EditRecipeInfoScreenModelTests: XCTestCase {

    var viewModel: EditRecipeInfoScreenModel!
    var mockDataHandler: RecipeDataHandler!
    var existingTags: [Tag]!
    var stubbedTag: Tag?

    override func setUp() {
        super.setUp()
        existingTags = [Tag(name: "Vegetarian"), Tag(name: "Spicy")]
        viewModel = EditRecipeInfoScreenModel()
        let dataProvider = DataProvider.shared
        mockDataHandler = .init(modelContainer: dataProvider.sharedModelContainer)
    }

    override func tearDown() {
        viewModel = nil
        mockDataHandler = nil
        existingTags = nil
        super.tearDown()
    }

    func testIsDoneInitial() {
        XCTAssertFalse(viewModel.validate())
    }

    func testIsDoneWithNameCategoryAndTime() {
        viewModel.name = .init(text: "Test Recipe")
        viewModel.category = .mainCourse
        viewModel.cookingTime = 3600

        XCTAssertTrue(viewModel.validate())
    }

    func testAddTagsWithExistingTag() async throws {
        try await viewModel.addTags(tagText: "Vegetarian", tags: existingTags, dataHandler: mockDataHandler)

        XCTAssertEqual(viewModel.tags.count, 1)
        XCTAssertEqual(viewModel.tags.first?.name, "Vegetarian")
    }

    func testAddTagsWithNewTag() async throws {
        stubbedTag = Tag(name: "Healthy")
        
        try await viewModel.addTags(tagText: "Healthy", tags: existingTags, dataHandler: mockDataHandler)

        XCTAssertEqual(viewModel.tags.count, 1)
        XCTAssertEqual(viewModel.tags.first?.name, "Healthy")
    }

    func testAddTagsWithEmptyText() async throws {
        try await viewModel.addTags(tagText: "", tags: existingTags, dataHandler: mockDataHandler)

        XCTAssertTrue(viewModel.tags.isEmpty)
    }

    func testAddTagsWithDuplicateTag() async throws {
        viewModel.tags.append(Tag(name: "Vegetarian"))

        try await viewModel.addTags(tagText: "Vegetarian", tags: existingTags, dataHandler: mockDataHandler)

        XCTAssertEqual(viewModel.tags.count, 1)
    }
}
