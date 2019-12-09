import Foundation

final class FavoritedCoffeeViewModel: CoffeeCollection {
    private lazy var coreDataService = CoreDataService()
    var coffeeList: CoffeeList
    var filteredCoffeeList = CoffeeList()

    init(coffeeList: CoffeeList? = nil) {
        self.coffeeList = coffeeList ?? CoffeeList()
    }
}

// MARK: Networking Methods
extension FavoritedCoffeeViewModel {
    func getCoffeeList(completion: (() -> Void)?) {
        self.coffeeList = Dictionary(grouping: self.coreDataService.fetchFavorites()){ $0.category }
        completion?()
    }
}

// MARK: - CoffeeFilter Methods
extension FavoritedCoffeeViewModel {
    func filterContentForSearchText(_ searchText: String, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            defer { completion() }
            guard let coffees = self?.coffeeList.values.flatMap({$0}) else { return }
            let data = [Coffee](coffees).filter{ $0.contains(searchText.lowercased()) }
            self?.filteredCoffeeList = Dictionary(grouping: data) { (coffee) in coffee.category }
        }
    }
}

// MARK: - Methods
extension FavoritedCoffeeViewModel {
    func addFavorite(_ coffee: Coffee) {
        guard let category = self.coffeeList[coffee.category],
            !category.contains(coffee)
            else { return }
        self.coffeeList[coffee.category]?.append(coffee)
        self.coreDataService.save(coffee)
    }

    func removeFavorite(section: Int, row: Int) {
        guard let coffee = self.coffeeList[self.coffeeCategories()[section]]?.remove(at: row)
            else { return }
//        self.coreDataService.context.delete(coffee)
        try? self.coreDataService.saveContext()
    }
}
