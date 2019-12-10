import UIKit

struct AppData {
    static let title = "illyCoffee"

    struct Colors {
        static let illyCoffee: UIColor = .systemRed
        static let lighterGray = UIColor(displayP3Red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
    }

    struct EmptyState {
        static let message = """
        You don't have any favorites.
        Save any coffee you like and
        it will appear here!
        """
    }
}
