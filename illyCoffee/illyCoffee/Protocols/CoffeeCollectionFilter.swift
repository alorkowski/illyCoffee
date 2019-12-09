import Foundation

protocol CoffeeCollectionFilter {
    func filterContentForSearchText(_ searchText: String, completion: @escaping () -> Void)
}
