import XCTest
@testable import illyCoffee

final class FeaturedCoffeeViewModelTests: XCTestCase {
    var sut: CoffeeCollectionManager!

    override func setUp() {
        super.setUp()
        self.sut = FeaturedCoffeeViewModel(isEditable: false, service: MockNetworkingService())
        let expectation = XCTestExpectation()
        self.sut.getCoffeeCollection(){ expectation.fulfill() }
        self.wait(for: [expectation], timeout: 0.1)
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }

    // MARK: Unit Test Utility Methods
    func filter() {
        let filterExpectation = XCTestExpectation()
        self.sut.filterContentForSearchText("Water"){ filterExpectation.fulfill() }
        self.wait(for: [filterExpectation], timeout: 0.1)
    }

    // MARK: Unit Tests
    func testIsEditable() {
        XCTAssertFalse(self.sut.isEditable)
    }

    func testCoffeeCategories() {
        XCTAssertEqual(["Coffee", "Not Coffee"], self.sut.coffeeCategories(filtered: false))
        self.filter()
        XCTAssertEqual(["Not Coffee"], self.sut.coffeeCategories(filtered: true))
    }

    func testNumberOfCoffees() {
        XCTAssertEqual(4, self.sut.numberOfCoffees(filtered: false))
        self.filter()
        XCTAssertEqual(1, self.sut.numberOfCoffees(filtered: true))
    }

    func testNumberOfSections() {
        XCTAssertEqual(2, self.sut.numberOfSections(filtered: false))
        self.filter()
        XCTAssertEqual(1, self.sut.numberOfSections(filtered: true))
    }

    func testNumberOfCoffeesInSection() {
        XCTAssertEqual(3, self.sut.numberOfCoffees(in: 0, filtered: false))
        XCTAssertEqual(1, self.sut.numberOfCoffees(in: 1, filtered: false))
        self.filter()
        XCTAssertEqual(1, self.sut.numberOfCoffees(in: 0, filtered: true))
    }

    func testGetCoffee() {
        let category = MockCoffeeData.collection.orderedKeys[0]
        let actual = self.sut.getCoffee(for: IndexPath(row: 1, section: 0), filtered: false)!
        XCTAssertEqual(MockCoffeeData.collection[category]![1], actual)
        self.filter()
        let filteredActual = self.sut.getCoffee(for: IndexPath(row: 0, section: 0), filtered: true)!
        XCTAssertEqual(MockCoffeeData.filteredCoffee, filteredActual)
    }

    func testGetCoffeeCategory() {
        let expected = "Coffee"
        let actual = self.sut.getCoffeeCategory(for: 0, filtered: false)
        XCTAssertEqual(expected, actual)
        self.filter()
        let filteredActual = self.sut.getCoffeeCategory(for: 0, filtered: true)
        XCTAssertEqual(MockCoffeeData.filteredCoffee.category, filteredActual)
    }
}
