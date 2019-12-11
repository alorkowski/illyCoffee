import XCTest
@testable import illyCoffee

final class FavoritedCoffeeViewModelTests: XCTestCase {
    var sut: CoffeeCollectionManager!
    var mockService: PersistenceService!

    override func setUp() {
        super.setUp()
        self.mockService = MockPersistenceService()
        self.sut = FavoritedCoffeeViewModel(isEditable: true, service: mockService)
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
        XCTAssert(self.sut.isEditable)
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
        let expected = MockCoffeeData.collection.orderedKeys[0]
        let actual = self.sut.getCoffeeCategory(for: 0, filtered: false)
        XCTAssertEqual(expected, actual)
        self.filter()
        let filteredActual = self.sut.getCoffeeCategory(for: 0, filtered: true)
        XCTAssertEqual(MockCoffeeData.filteredCoffee.category, filteredActual)
    }

    func testUpdateCoffeeCollection() {
        self.mockService.save(MockCoffeeData.newCoffee)
        let saveExpectation = XCTestExpectation()
        self.sut.updateCoffeeCollection(){ saveExpectation.fulfill() }
        self.wait(for: [saveExpectation], timeout: 0.1)
        XCTAssertEqual(5, self.sut.numberOfCoffees(filtered: false))
        XCTAssertEqual(1, self.sut.numberOfCoffees(in: 2))
        XCTAssertEqual(MockCoffeeData.newCoffee, self.sut.getCoffee(for: IndexPath(row: 0, section: 1))!)
        self.sut.deleteFavorite(in: 0, for: 2)
        let deleteExpectation = XCTestExpectation()
        self.sut.updateCoffeeCollection(){ deleteExpectation.fulfill() }
        self.wait(for: [deleteExpectation], timeout: 0.1)
        XCTAssertEqual(4, self.sut.numberOfCoffees(filtered: false))
        XCTAssertEqual(2, self.sut.numberOfCoffees(in: 0))
    }
}
