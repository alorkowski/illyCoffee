import XCTest
@testable import illyCoffee

final class CoffeeDetailViewModelTests: XCTestCase {
    var sut: CoffeeDetailViewModel!

    override func setUp() {
        super.setUp()
        self.sut = CoffeeDetailViewModel(with: MockCoffeeData.decodedData[0])
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }

    // MARK: Computed Properties Tests
    func testName() {
        XCTAssertEqual(MockCoffeeData.decodedData[0].name, self.sut.name)
    }

    func testDescription() {
        XCTAssertEqual(MockCoffeeData.decodedData[0].description, self.sut.description)
    }

    func testIngredients() {
        XCTAssertEqual(MockCoffeeData.decodedData[0].ingredients, self.sut.ingredients)
    }

    func testPreparation() {
        XCTAssertEqual(MockCoffeeData.decodedData[0].preparation, self.sut.preparation)
    }

    func testNumberOfIngredients() {
        XCTAssertEqual(MockCoffeeData.decodedData[0].ingredients.count, self.sut.numberOfIngredients)
    }

    func testNumberOfPreparations() {
        XCTAssertEqual(MockCoffeeData.decodedData[0].preparation.count, self.sut.numberOfPreparations)
    }
}
