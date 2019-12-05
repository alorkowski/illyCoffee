import XCTest
@testable import illyCoffee

final class CoffeeDetailViewModelTests: XCTestCase {
    var sut: CoffeeDetailViewModel!

    override func setUp() {
        self.sut = CoffeeDetailViewModel(with: MockCoffeeData.categoryA[1])
    }

    override func tearDown() {
        self.sut = nil
    }

    // MARK: Computed Properties
    func testNumberOfIngredients() {
        XCTAssertEqual(3, self.sut.numberOfIngredients)
    }

    func testNumberOfPreparations() {
        XCTAssertEqual(2, self.sut.numberOfPreparations)
    }
}
