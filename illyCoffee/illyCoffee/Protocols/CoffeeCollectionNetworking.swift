import Foundation

protocol CoffeeCollectionNetworking {
    func getCoffeeCollection(completion: (() -> Void)?)
    func updateCoffeeCollection(completion: (() -> Void)?)
}
