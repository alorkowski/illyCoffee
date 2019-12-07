import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = FeatureTabBarController()
        self.window?.makeKeyAndVisible()
        return true
    }
}
