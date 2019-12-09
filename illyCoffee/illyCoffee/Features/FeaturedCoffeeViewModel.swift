import Foundation

final class FeaturedCoffeeViewModel: CoffeeCollection {
    private lazy var networkService = NetworkService()
    var coffeeList: CoffeeList
    var filteredCoffeeList = CoffeeList()

    init(coffeeList: CoffeeList? = nil) {
        self.coffeeList = coffeeList ?? CoffeeList()
    }
}

// MARK: Networking Methods
extension FeaturedCoffeeViewModel {
    func getCoffeeList(completion: (() -> Void)?) {
        self.networkService.getLocalData(forResource: "illyCoffee", ofType: "json") {
            [weak self] (result: Result<[Coffee], NetworkError>) in
            switch result {
            case .success(let data):
                self?.coffeeList = Dictionary(grouping: data){ $0.category }
                completion?()
            case .failure(let error):
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - CoffeeFilter Methods
extension FeaturedCoffeeViewModel {
    func filterContentForSearchText(_ searchText: String, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            defer { completion() }
            guard let coffees = self?.coffeeList.values.flatMap({$0}) else { return }
            let data = [Coffee](coffees).filter{ $0.contains(searchText.lowercased()) }
            self?.filteredCoffeeList = Dictionary(grouping: data) { (coffee) in coffee.category }
        }
    }
}
