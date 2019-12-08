import Foundation

final class CoffeeDetailViewModel {
    let coffee: Coffee

    init(with coffee: Coffee) {
        self.coffee = coffee
    }
}

// MARK: - Computed Properties
extension CoffeeDetailViewModel {
    var numberOfIngredients: Int {
        return self.coffee.ingredients.count
    }

    var numberOfPreparations: Int {
        return self.coffee.preparation.count
    }
}
