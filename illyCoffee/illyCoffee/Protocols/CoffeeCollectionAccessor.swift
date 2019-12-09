import Foundation

protocol CoffeeCollectionAccessor {
    func coffeeCategories(filtered: Bool) -> [String]
    func numberOfSections(filtered: Bool) -> Int
    func numberOfCoffees(filtered: Bool) -> Int
    func numberOfCoffees(in section: Int, filtered: Bool) -> Int
    func getCoffee(for indexPath: IndexPath, filtered: Bool) -> Coffee?
    func getCoffeeCategory(for section: Int, filtered: Bool) -> String
}
