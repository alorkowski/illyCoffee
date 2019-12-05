import XCTest
@testable import illyCoffee

final class CoffeeListViewModelTests: XCTestCase {
    var sut: CoffeeListViewModel!

    override func setUp() {
        self.sut = CoffeeListViewModel(coffeeList: MockCoffeeData.mockData)
    }

    override func tearDown() {
        self.sut = nil
    }

    // MARK: Computed Properties
    func testCoffeeCategories() {
        XCTAssertEqual(["A", "B", "C"], self.sut.coffeeCategories)
    }

    func testNumberOfCoffees() {
        XCTAssertEqual(4, self.sut.numberOfCoffees)
    }

    func testNumberOfSections() {
        XCTAssertEqual(3, self.sut.numberOfSections)
    }

    // MARK: Methods
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
