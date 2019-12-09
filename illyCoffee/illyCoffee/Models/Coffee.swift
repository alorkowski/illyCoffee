import UIKit

final class Coffee: Decodable {
    let category: String
    let name: String
    let urlAlias: String
    let description: String
    let ingredients: [String]
    let preparation: [String]

    init(category: String,
         name: String,
         urlAlias: String,
         description: String,
         ingredients: [String],
         preparation: [String]) {
        self.category = category
        self.name = name
        self.urlAlias = urlAlias
        self.description = description
        self.ingredients = ingredients
        self.preparation = preparation
    }
}

// MARK: - Methods
extension Coffee {
    func contains(_ query: String) -> Bool {
        return self.name.lowercased().contains(query) || self.category.lowercased().contains(query)
    }
}

// MARK: - Equatable
extension Coffee: Equatable {
    static func ==(lhs: Coffee, rhs: Coffee) -> Bool {
        return lhs.urlAlias == rhs.urlAlias
    }
}
