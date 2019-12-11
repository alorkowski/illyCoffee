import Foundation

final class FavoritedCoffeeViewModel: CoffeeCollectionManager {
    private var coreDataService: PersistenceService!
    var coffeeCollection = CoffeeCollection()
    var filteredCoffeeCollection = CoffeeCollection()
    var isEditable: Bool

    init(isEditable: Bool, service: PersistenceService = CoreDataService.shared) {
        self.isEditable = isEditable
        self.coreDataService = service
    }
}

// MARK: Networking Methods
extension FavoritedCoffeeViewModel {
    func getCoffeeCollection(completion: (() -> Void)?) {
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            defer{ completion?() }
            guard let result = self?.coreDataService.fetchFavorites() else { return }
            self?.coffeeCollection = CoffeeCollection(from: Dictionary(grouping: result){ $0.category })
        }
    }

    func updateCoffeeCollection(completion: (() -> Void)?) {
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            guard let result = self?.coreDataService.updateWithLatest() else { return }
            self?.coffeeCollection = CoffeeCollection(from: Dictionary(grouping: result){ $0.category })
            completion?()
        }
    }
}

// MARK: - CoffeeCoreDataAdaptor Methods
extension FavoritedCoffeeViewModel {
    func deleteFavorite(in section: Int, for row: Int) {
        let category = self.coffeeCategories()[section]
        guard let coffee = self.coffeeCollection[category]?.remove(at: row) else { return }
        self.coreDataService.delete(coffee)
    }
}
