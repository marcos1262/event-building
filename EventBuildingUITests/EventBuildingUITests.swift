import XCTest

final class EventBuildingUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        let firstCategory = app.staticTexts["CategoryTitle"].firstMatch
        XCTAssert(firstCategory.waitForExistence(timeout: 10))
        firstCategory.tap()

        let firstItem = app.images["ItemAddAction"].firstMatch
        XCTAssert(firstItem.waitForExistence(timeout: 5))
        firstItem.tap()

        let backButton = app.buttons["BackButton"].firstMatch
        backButton.tap()

        let saveButton = app.buttons["SaveButton"].firstMatch
        saveButton.tap()

        let checkout = app.staticTexts["CheckoutTitle"].firstMatch
        XCTAssert(checkout.waitForExistence(timeout: 2))
    }
}
