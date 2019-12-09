import XCTest
@testable import illyCoffee

final class CoffeeCollectionManagerTests: XCTestCase {
    var sut: CoffeeCollectionManager!

    override func setUp() {
        self.sut = FeaturedCoffeeViewModel(isEditable: false, coffeeCollection: MockCoffeeData.mockData)
    }

    override func tearDown() {
        self.sut = nil
    }

    func testCoffeeCategories() {
        XCTAssertEqual(["A", "B", "C"], self.sut.coffeeCategories(filtered: false))
    }

    func testNumberOfCoffees() {
        XCTAssertEqual(4, self.sut.numberOfCoffees(filtered: false))
    }

    func testNumberOfSections() {
        XCTAssertEqual(3, self.sut.numberOfSections(filtered: false))
    }

    func testNumberOfCoffeesInSection() {
        XCTAssertEqual(3, self.sut.numberOfCoffees(in: 0))
        XCTAssertEqual(1, self.sut.numberOfCoffees(in: 1))
        XCTAssertEqual(0, self.sut.numberOfCoffees(in: 2))
    }

    func testGetCoffee() {
        let expected = MockCoffeeData.categoryA[1]
        let actual = self.sut.getCoffee(for: IndexPath(row: 1, section: 0))!
        XCTAssertEqual(expected, actual)
    }

    func testGetCoffeeCategory() {
        let expected = "A"
        let actual = self.sut.getCoffeeCategory(for: 0)
        XCTAssertEqual(expected, actual)
    }
}
