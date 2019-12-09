import UIKit

final class FeatureTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)

        let featuredVC = CoffeeListViewController(viewModel: FeaturedCoffeeViewModel(isEditable: false))
        featuredVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)

        let favoritedVC = CoffeeListViewController(viewModel: FavoritedCoffeeViewModel(isEditable: true))
        favoritedVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        self.viewControllers = [ UINavigationController(rootViewController: featuredVC),
                                 UINavigationController(rootViewController: favoritedVC)]
    }
}
