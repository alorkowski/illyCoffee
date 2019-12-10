import Foundation

typealias CoffeeCollection = [String: CoffeeArray]
typealias CoffeeArray = [Coffee]

protocol CoffeeCollectionManager: AnyObject, CoffeeCollectionAccessor, CoffeeCollectionFilter, CoffeeCoreDataAdaptor {
    var coffeeCollection: CoffeeCollection { get set }
    var filteredCoffeeCollection: CoffeeCollection { get set }
    var isEditable: Bool { get set }
    func getCoffeeCollection(completion: (() -> Void)?)
    func updateCoffeeCollection(completion: (() -> Void)?)
}

// MARK: - CoffeeCollectionAccessor Protocol Extension
extension CoffeeCollectionManager {
    func coffeeCategories(filtered: Bool = false) -> [String] {
        return filtered ? self.filteredCoffeeCollection.keys.sorted() : self.coffeeCollection.keys.sorted()
    }

    func numberOfSections(filtered: Bool = false) -> Int {
        return filtered ? self.filteredCoffeeCollection.count : self.coffeeCollection.count
    }

    func numberOfCoffees(filtered: Bool = false) -> Int {
        let coffeeList = filtered ? self.filteredCoffeeCollection : self.coffeeCollection
        return coffeeList.reduce(0){ $0 + $1.value.count }
    }

    func numberOfCoffees(in section: Int, filtered: Bool = false) -> Int {
        let coffeeList = filtered ? self.filteredCoffeeCollection : self.coffeeCollection
        guard let coffeeCategory = coffeeList[self.coffeeCategories(filtered: filtered)[section]]
            else { return 0 }
        return coffeeCategory.count
    }

    func getCoffee(for indexPath: IndexPath, filtered: Bool = false) -> Coffee? {
        let coffeeList = filtered ? self.filteredCoffeeCollection : self.coffeeCollection
        guard let coffeeCategory = coffeeList[self.coffeeCategories(filtered: filtered)[indexPath.section]]
            else { return nil }
        return coffeeCategory[indexPath.row]
    }

    func getCoffeeCategory(for section: Int, filtered: Bool = false) -> String {
        return self.coffeeCategories(filtered: filtered)[section]
    }
}

// MARK: - CoffeeCollectionFilter Methods
extension CoffeeCollectionManager {
    func filterContentForSearchText(_ searchText: String, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            defer { completion() }
            guard let coffees = self?.coffeeCollection.values.flatMap({$0}) else { return }
            let data = CoffeeArray(coffees).filter{ $0.contains(searchText.lowercased()) }
            self?.filteredCoffeeCollection = Dictionary(grouping: data) { (coffee) in coffee.category }
        }
    }
}
