import XCTest
@testable import illyCoffee

final class CoffeeLabelTableViewCellTests: XCTestCase {
    var sut: CoffeeLabelTableViewCell!

    override func setUp() {
        super.setUp()
        self.sut = CoffeeLabelTableViewCell(frame: .zero)
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }

    func testConfigureCell() {
        let coffee = MockCoffeeData.decodedData.first!
        self.sut.configure(with: coffee.name)
        XCTAssertEqual(coffee.name, self.sut.coffeeLabel.text)
    }
}
