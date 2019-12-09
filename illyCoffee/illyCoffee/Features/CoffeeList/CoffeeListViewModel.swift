import UIKit

typealias CoffeeList = [String: [Coffee]]

protocol CoffeeCollection: CoffeeListAccessor, CoffeeFilter {
    var coffeeList: CoffeeList { get set }
    var filteredCoffeeList: CoffeeList { get set }
}

protocol CoffeeListAccessor {
    func coffeeCategories(filtered: Bool) -> [String]
    func numberOfSections(filtered: Bool) -> Int
    func numberOfCoffees(filtered: Bool) -> Int
    func numberOfCoffees(in section: Int, filtered: Bool) -> Int
    func getCoffee(for indexPath: IndexPath, filtered: Bool) -> Coffee?
    func getCoffeeCategory(for section: Int, filtered: Bool) -> String
}

protocol CoffeeFilter {
    func filterContentForSearchText(_ searchText: String, completion: @escaping () -> Void)
}

extension CoffeeCollection {
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
