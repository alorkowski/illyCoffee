import Foundation
import CoreData

final class CoreDataService {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "illyCoffee")
        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() throws {
        try context.save()
    }
}

// MARK: - Methods
extension CoreDataService {
    func save(_ coffee: Coffee) {
        let favoriteCoffee = FavoriteCoffee(context: self.context)
        favoriteCoffee.category = coffee.category
        favoriteCoffee.name = coffee.name
        favoriteCoffee.urlAlias = coffee.urlAlias
        favoriteCoffee.summary = coffee.description
        favoriteCoffee.ingredients = coffee.ingredients
        favoriteCoffee.preparation = coffee.preparation
        guard self.context.hasChanges else { return }
        do {
            try self.saveContext()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func fetchFavorites() -> [Coffee] {
        let request: NSFetchRequest<FavoriteCoffee> = FavoriteCoffee.fetchRequest()
        do {
            let favoriteCoffeeList = try context.fetch(request)
            return favoriteCoffeeList.map{
                return Coffee(category: $0.category,
                              name: $0.name,
                              urlAlias: $0.urlAlias,
                              description: $0.summary,
                              ingredients: $0.ingredients,
                              preparation: $0.preparation)
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
