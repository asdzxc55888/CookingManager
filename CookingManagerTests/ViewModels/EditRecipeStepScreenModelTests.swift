//
//  EditRecipeStepScreenModelTests.swift
//  CookingManagerTests
//
//  Created by 何韋辰 on 2024/9/2.
//

import XCTest
@testable import CookingManager

final class EditRecipeStepScreenModelTests: XCTestCase {
    var viewModel: EditRecipeStepScreenModel!

    override func setUp() {
        super.setUp()
        viewModel = EditRecipeStepScreenModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialCookingSteps() {
        XCTAssertEqual(viewModel.cookingSteps.count, 1)
        XCTAssertEqual(viewModel.cookingSteps.first?.textField.text, "")
    }

    func testAddNewCookingStep() {
        viewModel.addNewCookingStep()
        XCTAssertEqual(viewModel.cookingSteps.count, 2)
        XCTAssertEqual(viewModel.cookingSteps.last?.textField.text, "")
    }

    func testDeleteCookingStep() {
        viewModel.addNewCookingStep()
        XCTAssertEqual(viewModel.cookingSteps.count, 2)

        viewModel.deleteCookingStep(at: 0)
        XCTAssertEqual(viewModel.cookingSteps.count, 1)
    }

    func testDeleteCookingStepInvalidIndex() {
        viewModel.addNewCookingStep()
        XCTAssertEqual(viewModel.cookingSteps.count, 2)

        viewModel.deleteCookingStep(at: 10)
        XCTAssertEqual(viewModel.cookingSteps.count, 2)
    }

    func testShowDeleteButton() {
        XCTAssertFalse(viewModel.showDeleteButton)

        viewModel.addNewCookingStep()
        XCTAssertTrue(viewModel.showDeleteButton)

        viewModel.deleteCookingStep(at: 1)
        XCTAssertFalse(viewModel.showDeleteButton)
    }

}
