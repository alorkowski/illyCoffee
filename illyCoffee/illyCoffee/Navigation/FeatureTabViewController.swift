import UIKit

final class FeatureTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)

        let featuredVM = CoffeeListViewModel(state: .featured)
        let featuredVC = CoffeeListViewController(viewModel: featuredVM)
        featuredVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)

        let favoritedVM = CoffeeListViewModel(state: .favorited)
        let favoriteVC = CoffeeListViewController(viewModel: favoritedVM)
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        self.viewControllers = [ UINavigationController(rootViewController: featuredVC),
                                 UINavigationController(rootViewController: favoriteVC)]
    }
}
