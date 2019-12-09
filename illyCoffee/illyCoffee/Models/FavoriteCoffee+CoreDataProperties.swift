import Foundation
import CoreData

extension FavoriteCoffee {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCoffee> {
        return NSFetchRequest<FavoriteCoffee>(entityName: "FavoriteCoffee")
    }

    @NSManaged public var category: String
    @NSManaged public var name: String
    @NSManaged public var urlAlias: String
    @NSManaged public var summary: String
    @NSManaged public var preparation: [String]
    @NSManaged public var ingredients: [String]
}
