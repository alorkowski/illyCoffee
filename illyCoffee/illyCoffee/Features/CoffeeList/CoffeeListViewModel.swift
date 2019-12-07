import UIKit

final class CoffeeListViewModel {
    private lazy var networkService = NetworkService()
    private var coffeeList: [String: [Coffee]]

    init(coffeeList: [String: [Coffee]]? = nil) {
        self.coffeeList = coffeeList ?? [String: [Coffee]]()
    }
}

// MARK: - Computed Properties
extension CoffeeListViewModel {
    var coffeeCategories: [String] {
        return self.coffeeList.keys.sorted()
    }

    var numberOfSections: Int {
        return self.coffeeList.count
    }

    var numberOfCoffees: Int {
        return self.coffeeList.reduce(0) { $0 + $1.value.count }
    }
}

// MARK: - Methods
extension CoffeeListViewModel {
    func numberOfCoffees(in section: Int) -> Int {
        guard let coffeeCategory = self.coffeeList[self.coffeeCategories[section]] else { return 0 }
        return coffeeCategory.count
    }

    func getCoffee(for indexPath: IndexPath) -> Coffee? {
        guard let coffeeCategory = self.coffeeList[self.coffeeCategories[indexPath.section]] else { return nil }
        return coffeeCategory[indexPath.row]
    }

    func getCoffeeCategory(for section: Int) -> String {
        return self.coffeeCategories[section]
    }
}

// MARK: - Network Functions
extension CoffeeListViewModel {
    func retrieveCoffeeData(completion: (() -> Void)?) {
        let closure = {
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
        self.networkService.getLocalData(forResource: "illyCoffee",
                                         ofType: "json",
                                         completion: closure)
    }
}
