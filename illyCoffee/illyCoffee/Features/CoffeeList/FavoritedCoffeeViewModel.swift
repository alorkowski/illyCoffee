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

// MARK: - CoffeeCoreDataAdaptor Methods
extension FavoritedCoffeeViewModel {
    func addFavorite(_ coffee: Coffee) {
        guard let category = self.coffeeCollection[coffee.category],
            !category.contains(coffee)
            else { return }
        self.coffeeCollection[coffee.category]?.append(coffee)
        self.coreDataService.save(coffee)
    }

    func deleteFavorite(in section: Int, for row: Int) {
        guard let coffee = self.coffeeCollection[self.coffeeCategories()[section]]?.remove(at: row)
            else { return }
        let favoriteCoffee = FavoriteCoffee(context: coreDataService.context)
        favoriteCoffee.category = coffee.category
        favoriteCoffee.name = coffee.name
        favoriteCoffee.urlAlias = coffee.urlAlias
        favoriteCoffee.summary = coffee.description
        favoriteCoffee.ingredients = coffee.ingredients
        favoriteCoffee.preparation = coffee.preparation
        self.coreDataService.context.delete(favoriteCoffee)
        try? self.coreDataService.saveContext()
    }
}
