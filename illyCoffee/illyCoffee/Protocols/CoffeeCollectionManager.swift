import Foundation

typealias CoffeeArray = [Coffee]
typealias CoffeeCollection = OrderedDictionary<String, CoffeeArray>
typealias CoffeeCollectionTraits = CoffeeCollectionAccessor & CoffeeCollectionFilter & CoffeeCollectionNetworking & CoffeeCoreDataAdaptor

protocol CoffeeCollectionManager: AnyObject, CoffeeCollectionTraits {
    var coffeeCollection: CoffeeCollection { get set }
    var filteredCoffeeCollection: CoffeeCollection { get set }
    var isEditable: Bool { get set }
    func delete(category: String)
}

// MARK: - CoffeeCollectionManager Protocol Extension
extension CoffeeCollectionManager {
    func delete(category: String) {
        self.coffeeCollection[category] = nil
    }
}

// MARK: - CoffeeCollectionAccessor Protocol Extension
extension CoffeeCollectionManager {
    func coffeeCategories(filtered: Bool = false) -> [String] {
        return filtered ? self.filteredCoffeeCollection.orderedKeys : self.coffeeCollection.orderedKeys
    }

    func numberOfSections(filtered: Bool = false) -> Int {
        return filtered ? self.filteredCoffeeCollection.count : self.coffeeCollection.count
    }

    func numberOfCoffees(filtered: Bool = false) -> Int {
        let coffeeList = filtered ? self.filteredCoffeeCollection.values : self.coffeeCollection.values
        return coffeeList.reduce(0){ $0 + $1.count }
    }

    func numberOfCoffees(in section: Int, filtered: Bool = false) -> Int {
        let collection = filtered ? self.filteredCoffeeCollection : self.coffeeCollection
        guard let coffeeCategory = collection[self.coffeeCategories(filtered: filtered)[section]]
            else { return 0 }
        return coffeeCategory.count
    }

    func getCoffee(for indexPath: IndexPath, filtered: Bool = false) -> Coffee? {
        let collection = filtered ? self.filteredCoffeeCollection : self.coffeeCollection
        guard let coffeeCategory = collection[self.coffeeCategories(filtered: filtered)[indexPath.section]]
            else { return nil }
        return coffeeCategory[indexPath.row]
    }

    func getCoffeeCategory(for section: Int, filtered: Bool = false) -> String {
        return self.coffeeCategories(filtered: filtered)[section]
    }

    func isEmpty(_ category: String) -> Bool {
        return self.coffeeCollection[category]?.count == 0
    }
}

// MARK: - CoffeeCollectionFilter Methods
extension CoffeeCollectionManager {
    func filterContentForSearchText(_ searchText: String, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            defer { completion() }
            guard let coffees = self?.coffeeCollection.values.flatMap({$0}) else { return }
            let data = CoffeeArray(coffees).filter{ $0.contains(searchText.lowercased()) }
            self?.filteredCoffeeCollection = CoffeeCollection(from: Dictionary(grouping: data){ $0.category })
        }
    }
}
