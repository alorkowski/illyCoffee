import Foundation

extension Array where Iterator.Element: FavoriteCoffee {
    func convertToCoffeeArray() -> CoffeeArray {
        return self.map{
            Coffee(category: $0.category,
                   name: $0.name,
                   urlAlias: $0.urlAlias,
                   description: $0.summary,
                   ingredients: $0.ingredients,
                   preparation: $0.preparation)
        }
    }
}
