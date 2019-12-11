import XCTest
@testable import illyCoffee

final class OrderedDicitonaryTests: XCTestCase {
    var sut: OrderedDictionary<String, Int>!
    let dictionary = [ "Oranges": 5,
                       "Pears": 2,
                       "Apples": 3 ]

    override func setUp() {
        super.setUp()
        self.sut = OrderedDictionary(from: dictionary)
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }

    // MARK: Computed Property Tests
    func testOrderedKeys() {
        XCTAssertEqual(["Apples", "Oranges", "Pears"], self.sut.orderedKeys)
    }

    func testCount() {
        XCTAssertEqual(3, self.sut.count)
    }

    func testIsEmpty() {
        XCTAssertFalse(self.sut.isEmpty)
    }

    // MARK: Subscript Tests
    func testSettingNewValue() {
        self.sut["Grapes"] = 2
        XCTAssertEqual(["Apples", "Grapes", "Oranges", "Pears"], self.sut.orderedKeys)
        XCTAssertEqual(4, self.sut.count)
        XCTAssertFalse(self.sut.isEmpty)
        XCTAssertEqual(2, self.sut["Grapes"])
    }

    func testUpdatingValue() {
        self.sut["Apples"] = 100
        XCTAssertEqual(["Apples", "Oranges", "Pears"], self.sut.orderedKeys)
        XCTAssertEqual(3, self.sut.count)
        XCTAssertFalse(self.sut.isEmpty)
        XCTAssertEqual(100, self.sut["Apples"])
    }

    func testDeletingValue() {
        self.sut["Apples"] = nil
        XCTAssertEqual(["Oranges", "Pears"], self.sut.orderedKeys)
        XCTAssertEqual(2, self.sut.count)
        XCTAssertFalse(self.sut.isEmpty)
        XCTAssertEqual(nil, self.sut["Apples"])
        self.sut["Oranges"] = nil
        self.sut["Pears"] = nil
        XCTAssertEqual([], self.sut.orderedKeys)
        XCTAssertEqual(0, self.sut.count)
        XCTAssert(self.sut.isEmpty)
    }
}
