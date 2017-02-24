import UIKit

extension UINavigationController {
    
    func topView(hidden: Bool) {
        self.navigationBar.isHidden = hidden
    }
    
    func clearToNavigationController() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
    }
    
}
