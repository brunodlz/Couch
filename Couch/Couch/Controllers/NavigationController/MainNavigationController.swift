import UIKit

final class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = ColorPalette.black
        UINavigationBar.appearance().tintColor = ColorPalette.white
        UINavigationBar.appearance().isTranslucent = false
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ColorPalette.white]
        self.clearToNavigationController()
    }
}
