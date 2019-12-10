import Foundation
import CoreData

final class CoreDataService {
    static let shared = CoreDataService()
    private init() {}
    private var managedObjects = [FavoriteCoffee]()

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
        guard !managedObjects.contains(where: { $0.urlAlias == coffee.urlAlias }) else { return }
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
            self.managedObjects.append(favoriteCoffee)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func fetchFavorites() -> CoffeeArray {
        let request: NSFetchRequest<FavoriteCoffee> = FavoriteCoffee.fetchRequest()
        do {
            self.managedObjects = try context.fetch(request)
            return self.managedObjects.convertToCoffeeArray()
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func delete(_ coffee: Coffee) {
        guard let index = self.managedObjects.firstIndex(where: { $0.urlAlias == coffee.urlAlias }) else { return }
        self.context.delete(self.managedObjects[index])
        do {
            try self.saveContext()
            self.managedObjects.remove(at: index)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func updateWithLatest() -> CoffeeArray {
        return self.managedObjects.convertToCoffeeArray()
    }
}
