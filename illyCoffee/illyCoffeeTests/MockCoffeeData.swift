import Foundation
@testable import illyCoffee

struct MockCoffeeData {
    static let categoryA = [ Coffee(category: "A",
                                    name: "A1",
                                    urlAlias: "A1URL",
                                    description: "A1A1A1A1",
                                    ingredients: ["I1", "I2"],
                                    preparation: ["1) Shake", "2) Stir"]),
                             Coffee(category: "A",
                                    name: "A2",
                                    urlAlias: "A2URL",
                                    description: "A2A2A2A2",
                                    ingredients: ["I1", "I2", "I3"],
                                    preparation: ["1) Infinite Loop... see Loop Indefinitely",
                                                  "2) Loop Indefinitely... see Infinite Loop"]),
                             Coffee(category: "A",
                                    name: "A3",
                                    urlAlias: "A3URL",
                                    description: "A3A3A3A3",
                                    ingredients: [],
                                    preparation: [])]
    static let categoryB = [ Coffee(category: "B",
                                    name: "Water",
                                    urlAlias: "B1URL",
                                    description: "It's water...",
                                    ingredients: ["Water"],
                                    preparation: ["1) Pour water into a glass."]) ]
    static let categoryC: CoffeeArray = []

    static let mockData: CoffeeCollection = [ "A" : Self.categoryA,
                                              "B" : Self.categoryB,
                                              "C" : Self.categoryC ]
}
