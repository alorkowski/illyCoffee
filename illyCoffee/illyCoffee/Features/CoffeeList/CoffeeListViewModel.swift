import UIKit

final class CoffeeListViewModel {
    enum CoffeeListState {
        case featured
        case favorited
    }

    private let state: CoffeeListState
    private var coffeeList: [String: [Coffee]]
    private var filteredCoffeeList: [String: [Coffee]]

    init(state: CoffeeListState, coffeeList: [String: [Coffee]]? = nil) {
        self.state = state
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
    func getCoffeeList(completion: (() -> Void)?) {
        switch self.state {
        case .featured:
            CoffeeManager.shared.getCoffeeList { [weak self] coffeeList in
                self?.coffeeList = coffeeList
                completion?()
            }
        case .favorited:
            CoffeeManager.shared.getFavoriteCoffeeList { [weak self] coffeeList in
                self?.coffeeList = coffeeList
                completion?()
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
