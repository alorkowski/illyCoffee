import Foundation
@testable import illyCoffee

struct MockCoffeeData {
    static let json: [[String: Any]] = [["category": "Coffee",
                                         "name": "A1",
                                         "urlAlias": "A1URL",
                                         "description": "A1A1A1A1",
                                         "ingredients": ["I1", "I2"],
                                         "preparation": ["1) Shake", "2) Stir"]],
                                        ["category": "Coffee",
                                         "name": "A2",
                                         "urlAlias": "A2URL",
                                         "description": "A2A2A2A2",
                                         "ingredients": ["I1", "I2", "I3"],
                                         "preparation": [
                                            "1) Infinite Loop... see Loop Indefinitely",
                                            "2) Loop Indefinitely... see Infinite Loop"]],
                                        ["category": "Coffee",
                                         "name": "Deletable Coffee",
                                         "urlAlias": "deleteCoffee",
                                         "description": "The coffee is removable",
                                         "ingredients": ["Nothing important"],
                                         "preparation": ["Swipe to delete in main app"]],
                                        ["category": "Not Coffee",
                                         "name": "Water",
                                         "urlAlias": "water",
                                         "description": "It's water...",
                                         "ingredients": ["Water"],
                                         "preparation": ["1) Pour water into a glass."]]]

    static let data = try! JSONSerialization.data(withJSONObject: Self.json, options:[])
    static let decodedData = try! JSONDecoder().decode(CoffeeArray.self, from: Self.data)
    static let collection = CoffeeCollection(from: Dictionary(grouping: Self.decodedData){ $0.category })

    static let newCoffee = Coffee(category: "Favorite",
                                  name: "THE BEST",
                                  urlAlias: "thebest",
                                  description: "The Greatest Coffee Ever",
                                  ingredients: ["The Greatest Ingredient Ever"],
                                  preparation: ["Make the Greatest Coffee Ever with the Greatest Ingredient Ever"])
    static let deletableCoffee = Coffee(category: "Coffee",
                                        name: "Deletable Coffee",
                                        urlAlias: "deleteCoffee",
                                        description: "The coffee is removable",
                                        ingredients: ["Nothing important"],
                                        preparation: ["Swipe to delete in main app"])
    static let filteredCoffee = Coffee(category: "Not Coffee",
                                       name: "Water",
                                       urlAlias: "water",
                                       description: "It's water...",
                                       ingredients: ["Water"],
                                       preparation: ["1) Pour water into a glass."])

}
