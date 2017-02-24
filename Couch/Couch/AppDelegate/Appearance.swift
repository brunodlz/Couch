import UIKit

struct Appearance {
    
    static let tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    static func customize() {
        UIWindow.appearance().tintColor = tintColor
    }
    
}
