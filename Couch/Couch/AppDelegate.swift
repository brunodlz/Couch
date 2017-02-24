import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var flowManager: FlowManager!
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Appearance.customize()
        
        flowManager = FlowManager()
        flowManager.showInitialViewController()
        
        return true
    }
}

