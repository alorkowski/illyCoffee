import UIKit

final class FeatureTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [ EmptyViewController() ]
    }
}
