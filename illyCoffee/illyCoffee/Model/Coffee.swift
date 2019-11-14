import UIKit

final class Coffee: Decodable {
    let category: String
    let name: String
    let urlAlias: String
    let description: String
    let ingredients: [String]
    let preparation: [String]

    lazy var image: UIImage? = {
        return UIImage(named: self.urlAlias)
    }()
}

extension Coffee: Equatable {
    static func ==(lhs: Coffee, rhs: Coffee) -> Bool {
        return lhs.urlAlias == rhs.urlAlias
    }
}
