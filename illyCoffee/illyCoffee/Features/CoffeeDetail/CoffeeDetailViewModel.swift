import Foundation
import CoreData

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

// MARK: - CoreData Methods
//extension CoffeeDetailViewModel {
//    func save() {
//        CoffeeManager.shared.addFavorite(self.coffee)
//    }
//}
