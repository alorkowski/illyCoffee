import UIKit

final class CoffeeListViewModel {
    private lazy var networkService = NetworkService()
    private var coffeeList: [String: [Coffee]]
    private var filteredCoffeeList: [String: [Coffee]]

    init(coffeeList: [String: [Coffee]]? = nil) {
        self.coffeeList = coffeeList ?? [String: [Coffee]]()
        self.filteredCoffeeList = [String: [Coffee]]()
    }
}

// MARK: - Methods
extension CoffeeListViewModel {
    func coffeeCategories(filtered: Bool = false) -> [String] {
        return filtered ? self.filteredCoffeeList.keys.sorted() : self.coffeeList.keys.sorted()
    }

    func numberOfSections(filtered: Bool = false) -> Int {
        return filtered ? self.filteredCoffeeList.count : self.coffeeList.count
    }

    func numberOfCoffees(filtered: Bool = false) -> Int {
        let coffeeList = filtered ? self.filteredCoffeeList : self.coffeeList
        return coffeeList.reduce(0){ $0 + $1.value.count }
    }

    func numberOfCoffees(in section: Int, filtered: Bool = false) -> Int {
        let coffeeList = filtered ? self.filteredCoffeeList : self.coffeeList
        guard let coffeeCategory = coffeeList[self.coffeeCategories(filtered: filtered)[section]]
            else { return 0 }
        return coffeeCategory.count
    }

    func getCoffee(for indexPath: IndexPath, filtered: Bool = false) -> Coffee? {
        let coffeeList = filtered ? self.filteredCoffeeList : self.coffeeList
        guard let coffeeCategory = coffeeList[self.coffeeCategories(filtered: filtered)[indexPath.section]]
            else { return nil }
        return coffeeCategory[indexPath.row]
    }

    func getCoffeeCategory(for section: Int, filtered: Bool = false) -> String {
        return self.coffeeCategories(filtered: filtered)[section]
    }
}

// MARK: - Networking Methods
extension CoffeeListViewModel {
    func retrieveCoffeeData(completion: (() -> Void)?) {
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
}

// MARK: - SearchController Methods
extension CoffeeListViewModel {
    func filterContentForSearchText(_ searchText: String, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            defer { completion() }
            guard let coffees = self?.coffeeList.values.flatMap({$0}) else { return }
            let data = [Coffee](coffees).filter{ $0.contains(searchText.lowercased()) }
            self?.filteredCoffeeList = Dictionary(grouping: data) { (coffee) in coffee.category }
        }
    }
}
