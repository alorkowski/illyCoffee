import Foundation

final class FavoritedCoffeeViewModel: CoffeeCollectionManager {
    private var coreDataService = CoreDataService.shared
    var coffeeCollection: CoffeeCollection
    var filteredCoffeeCollection: CoffeeCollection = [:]
    var isEditable: Bool

    init(isEditable: Bool, coffeeCollection: CoffeeCollection? = nil) {
        self.isEditable = isEditable
        self.coffeeCollection = coffeeCollection ?? CoffeeCollection()
    }
}

// MARK: Networking Methods
extension FavoritedCoffeeViewModel {
    func getCoffeeCollection(completion: (() -> Void)?) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.coffeeCollection = Dictionary(grouping: self.coreDataService.fetchFavorites()){ $0.category }
            completion?()
        }
    }

    func updateCoffeeCollection(completion: (() -> Void)?) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.coffeeCollection = self.coreDataService.updateWithLatest()
            completion?()
        }
    }
}

// MARK: - CoffeeFilter Methods
extension FavoritedCoffeeViewModel {
    func filterContentForSearchText(_ searchText: String, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            defer { completion() }
            guard let coffees = self?.coffeeCollection.values.flatMap({$0}) else { return }
            let data = CoffeeArray(coffees).filter{ $0.contains(searchText.lowercased()) }
            self?.filteredCoffeeCollection = Dictionary(grouping: data) { (coffee) in coffee.category }
        }
    }
}

// MARK: - CoffeeCoreDataAdaptor Methods
extension FavoritedCoffeeViewModel {
    func deleteFavorite(in section: Int, for row: Int) {
        guard let coffee = self.coffeeCollection[self.coffeeCategories()[section]]?.remove(at: row)
            else { return }
        self.coreDataService.delete(coffee)
        try? self.coreDataService.saveContext()
    }
}
