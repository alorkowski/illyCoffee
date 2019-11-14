import UIKit

final class CoffeeListViewModel {
    // TODO: Probably a good idea to do this in the background thread especially when the json gets large
    lazy var coffeeList: [String: [Coffee]] = {
        guard let path = Bundle.main.path(forResource: "illyCoffee", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let decodedData = try? JSONDecoder().decode([Coffee].self, from: data)
            else { return [:] }
        return Dictionary(grouping: decodedData) { (coffee: Coffee) in coffee.category }
    }()

    var coffeeCategories: [String] {
        return coffeeList.keys.sorted()
    }
}

// MARK: - Computed Properties
extension CoffeeListViewModel {
    var numberOfSections: Int {
        return coffeeList.count
    }

    var numberOfCoffees: Int {
        return coffeeList.reduce(0) { $0 + $1.value.count }
    }
}

// MARK: - Functions
extension CoffeeListViewModel {
    func numberOfCoffees(in section: Int) -> Int {
        guard let coffeeCategory = coffeeList[self.coffeeCategories[section]] else { return 0 }
        return coffeeCategory.count
    }

    func getCoffee(for indexPath: IndexPath) -> Coffee? {
        guard let coffeeCategory = coffeeList[self.coffeeCategories[indexPath.section]] else { return nil }
        return coffeeCategory[indexPath.row]
    }

    func getCoffeeCategory(for section: Int) -> String {
        return self.coffeeCategories[section]
    }
}
