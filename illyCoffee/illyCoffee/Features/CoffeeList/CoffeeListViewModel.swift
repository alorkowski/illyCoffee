import Foundation

final class CoffeeListViewModel {
    lazy var coffeeList: [Coffee] = {
        guard let path = Bundle.main.path(forResource: "illyCoffee", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let decodedData = try? JSONDecoder().decode([Coffee].self, from: data)
            else { return [] }
        return decodedData
    }()
}

// MARK: - Computed Properties
extension CoffeeListViewModel {
    var numberOfCoffees: Int {
        return coffeeList.count
    }
}
