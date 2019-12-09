import Foundation

protocol CoffeeCoreDataAdaptor {
    func addFavorite()
    func add(favorite coffee: Coffee)
    func deleteFavorite()
    func delete(favorite coffee: Coffee)
    func deleteFavorite(in section: Int, for row: Int)
}

extension CoffeeCoreDataAdaptor {
    func addFavorite() {
        fatalError("addFavorite() has not been implemented")
    }

    func add(favorite coffee: Coffee) {
        fatalError("add(favorite:) has not been implemented")
    }

    func deleteFavorite() {
        fatalError("deleteFavorite() has not been implemented")
    }

    func delete(favorite coffee: Coffee) {
        fatalError("delete(favorite:) has not been implemented")
    }

    func deleteFavorite(in section: Int, for row: Int) {
        fatalError("delete(in:for:) has not been implemented")
    }
}
