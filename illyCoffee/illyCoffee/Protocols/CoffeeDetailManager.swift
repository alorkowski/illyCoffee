import Foundation

protocol CoffeeDetailManager: CoffeeCoreDataAdaptor {
    var coffee: Coffee { get set }
    var numberOfIngredients: Int { get }
    var numberOfPreparations: Int { get }
}

// MARK: - CoffeeDetailManager Protocol Extension
extension CoffeeDetailManager {
    var numberOfIngredients: Int {
        return self.coffee.ingredients.count
    }

    var numberOfPreparations: Int {
        return self.coffee.preparation.count
    }
}
