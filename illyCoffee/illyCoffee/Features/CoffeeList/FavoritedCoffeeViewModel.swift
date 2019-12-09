import Foundation

final class FavoritedCoffeeViewModel: CoffeeCollectionManager {
    private lazy var coreDataService = CoreDataService()
    var coffeeCollection: CoffeeCollection
    var filteredCoffeeCollection: CoffeeCollection = [:]

    init(coffeeCollection: CoffeeCollection? = nil) {
        self.coffeeCollection = coffeeCollection ?? CoffeeCollection()
    }
}

// MARK: Networking Methods
extension FavoritedCoffeeViewModel {
    func getCoffeeCollection(completion: (() -> Void)?) {
        self.coffeeCollection = Dictionary(grouping: self.coreDataService.fetchFavorites()){ $0.category }
        completion?()
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

// MARK: - Methods
extension FavoritedCoffeeViewModel {
    func addFavorite(_ coffee: Coffee) {
        guard let category = self.coffeeCollection[coffee.category],
            !category.contains(coffee)
            else { return }
        self.coffeeCollection[coffee.category]?.append(coffee)
        self.coreDataService.save(coffee)
    }

    func removeFavorite(section: Int, row: Int) {
        guard let coffee = self.coffeeCollection[self.coffeeCategories()[section]]?.remove(at: row)
            else { return }
//        self.coreDataService.context.delete(coffee)
        try? self.coreDataService.saveContext()
    }
}
