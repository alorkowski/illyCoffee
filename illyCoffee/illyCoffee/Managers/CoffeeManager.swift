import Foundation

final class CoffeeManager {
    static let shared = CoffeeManager()
    private lazy var coreDataService = CoreDataService()
    private lazy var networkService = NetworkService()
    private var coffeeList: [String: [Coffee]]?
    private var favoriteCoffeeList: [String: [Coffee]]?
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

    func save(_ coffee: Coffee) {
        self.coreDataService.save(coffee)
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
        completion?(self.coreDataService.fetchFavorites())
    }
}
