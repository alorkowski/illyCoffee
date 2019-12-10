import Foundation

final class FeaturedCoffeeViewModel: CoffeeCollectionManager {
    private lazy var networkService = NetworkService()
    var coffeeCollection: CoffeeCollection
    var filteredCoffeeCollection = CoffeeCollection()
    var isEditable: Bool

    init(isEditable: Bool, coffeeCollection: CoffeeCollection? = nil) {
        self.isEditable = isEditable
        self.coffeeCollection = coffeeCollection ?? CoffeeCollection()
    }
}

// MARK: Networking Methods
extension FeaturedCoffeeViewModel {
    func getCoffeeCollection(completion: (() -> Void)?) {
        self.networkService.getLocalData(forResource: "illyCoffee", ofType: "json") {
            [weak self] (result: Result<CoffeeArray, NetworkError>) in
            switch result {
            case .success(let data):
                self?.coffeeCollection = CoffeeCollection(from: Dictionary(grouping: data){ $0.category })
                completion?()
            case .failure(let error):
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }

    func updateCoffeeCollection(completion: (() -> Void)?) {
        // Do nothing
    }
}
