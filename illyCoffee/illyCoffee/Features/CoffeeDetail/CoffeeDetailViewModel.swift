import Foundation
import CoreData

final class CoffeeDetailViewModel: CoffeeDetailManager {
    private let coreDataService = CoreDataService.shared
    var coffee: Coffee

    init(with coffee: Coffee) {
        self.coffee = coffee
    }
}

// MARK: CoffeeCoreDataAdaptor Methods
extension CoffeeDetailViewModel {
    func addFavorite() {
        self.coreDataService.save(self.coffee)
    }
}
