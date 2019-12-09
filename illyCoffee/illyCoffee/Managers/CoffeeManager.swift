import Foundation

final class CoffeeManager {
    static let shared = CoffeeManager()
    private lazy var coreDataService = CoreDataService()
    private lazy var networkService = NetworkService()
    private var coffeeList: [String: [Coffee]]?
    private var favoriteCoffeeList: [String: [Coffee]]?
    private var coreDataCoffee = [FavoriteCoffee]()
}

// MARK: - Methods
extension CoffeeManager {
    func getCoffeeList(completion: (([String: [Coffee]]) -> Void)?) {
        if let coffeeList = self.coffeeList {
            completion?(coffeeList)
        } else {
            self.retrieveCoffeeData { [weak self] in completion?(self?.coffeeList ?? [:]) }
        }
    }

    func getFavoriteCoffeeList(completion: (([String: [Coffee]]) -> Void)?) {
        self.retrieveFavoriteCoffeeData {
            [weak self] coffees in
            self?.favoriteCoffeeList = Dictionary(grouping: coffees) { $0.category }
            completion?(self?.favoriteCoffeeList ?? [:])
        }
    }

    func addFavorite(_ coffee: Coffee) {
        if self.favoriteCoffeeList == nil { self.getFavoriteCoffeeList(completion: nil) }
        guard let category = self.favoriteCoffeeList?[coffee.category],
            !category.contains(coffee)
            else { return }
        self.favoriteCoffeeList?[coffee.category]?.append(coffee)
        self.coreDataService.save(coffee)
    }

    func removeFavorite(_ coffee: Coffee) {
        guard let index = self.coreDataCoffee.firstIndex(where: { $0.urlAlias == coffee.urlAlias }) else { return }
        let deletedCoffee = self.coreDataCoffee.remove(at: index)
        let coffees = self.coreDataCoffee.map{
            return Coffee(category: $0.category,
                          name: $0.name,
                          urlAlias: $0.urlAlias,
                          description: $0.summary,
                          ingredients: $0.ingredients,
                          preparation: $0.preparation)
        }
        self.favoriteCoffeeList = Dictionary(grouping: coffees) { $0.category }
        self.coreDataService.context.delete(deletedCoffee)
        try? self.coreDataService.saveContext()
    }
}

// MARK: Networking Methods
extension CoffeeManager {
    private func retrieveCoffeeData(completion: (() -> Void)?) {
        self.networkService.getLocalData(forResource: "illyCoffee", ofType: "json") {
            [weak self] (result: Result<[Coffee], NetworkError>) in
            switch result {
            case .success(let data):
                self?.coffeeList = Dictionary(grouping: data) { (coffee) in
                    coffee.category
                }
                completion?()
            case .failure(let error):
                fatalError("Error: \(error.localizedDescription)")
                break
            }
        }
    }

    private func retrieveFavoriteCoffeeData(completion: (([Coffee]) -> Void)?) {
        self.coreDataCoffee = self.coreDataService.fetchFavorites()
        let coffees = self.coreDataCoffee.map{
            return Coffee(category: $0.category,
                          name: $0.name,
                          urlAlias: $0.urlAlias,
                          description: $0.summary,
                          ingredients: $0.ingredients,
                          preparation: $0.preparation)
        }
        completion?(coffees)
    }
}
