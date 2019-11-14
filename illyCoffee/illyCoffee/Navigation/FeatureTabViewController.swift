import UIKit

final class FeatureTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)

        let coffeeListViewController = CoffeeListViewController()
        coffeeListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)

        self.viewControllers = [ UINavigationController(rootViewController: coffeeListViewController) ]
    }
}
