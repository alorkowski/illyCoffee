import Foundation
@testable import illyCoffee

final class MockPersistenceService: PersistenceService {
    var managedObjects = MockCoffeeData.decodedData

    func save(_ coffee: Coffee) {
        self.managedObjects.append(coffee)
    }

    func fetchFavorites() -> CoffeeArray {
        return self.managedObjects
    }

    func delete(_ coffee: Coffee) {
        guard let index = self.managedObjects.firstIndex(where: { $0.urlAlias == coffee.urlAlias }) else { return }
        self.managedObjects.remove(at: index)
    }

    func updateWithLatest() -> CoffeeArray {
        return self.managedObjects
    }
}
