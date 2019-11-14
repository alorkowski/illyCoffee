import UIKit

final class FeatureTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let coffeeListViewController = CoffeeListViewController()
        coffeeListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)

        self.viewControllers = [ UINavigationController(rootViewController: coffeeListViewController) ]
    }
}
