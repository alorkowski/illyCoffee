import Foundation

protocol PersistenceService {
    func save(_ coffee: Coffee)
    func fetchFavorites() -> CoffeeArray
    func delete(_ coffee: Coffee)
    func updateWithLatest() -> CoffeeArray
}
