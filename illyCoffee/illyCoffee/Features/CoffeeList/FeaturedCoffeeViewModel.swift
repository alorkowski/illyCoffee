import Foundation

final class FeaturedCoffeeViewModel: CoffeeCollectionManager {
    private let networkService: NetworkingService!
    var coffeeCollection = CoffeeCollection()
    var filteredCoffeeCollection = CoffeeCollection()
    var isEditable: Bool

    init(isEditable: Bool, service: NetworkingService? = NetworkService()) {
        self.isEditable = isEditable
        self.networkService = service
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
