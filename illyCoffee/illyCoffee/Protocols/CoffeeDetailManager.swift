import Foundation

protocol CoffeeDetailManager: CoffeeCoreDataAdaptor {
    var coffee: Coffee { get set }
    var name: String { get }
    var description: String { get }
    var ingredients: [String] { get }
    var preparation: [String] { get }
    var numberOfIngredients: Int { get }
    var numberOfPreparations: Int { get }
}

// MARK: - CoffeeDetailManager Protocol Extension
extension CoffeeDetailManager {
    var name: String {
        return self.coffee.name
    }

    var description: String {
        return self.coffee.description
    }

    var ingredients: [String] {
        return self.coffee.ingredients
    }

    var preparation: [String] {
        return self.coffee.preparation
    }

    var numberOfIngredients: Int {
        return self.ingredients.count
    }

    var numberOfPreparations: Int {
        return self.preparation.count
    }
}
