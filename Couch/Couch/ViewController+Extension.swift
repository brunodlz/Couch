import UIKit

extension UIViewController {
    
    func didRequest() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdate() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
