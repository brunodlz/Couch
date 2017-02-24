import UIKit

class Label: UILabel {
    
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect)
        
        self.font          = UIFont.systemFont(ofSize: 14)
        self.textColor     = ColorPalette.white
        self.textAlignment = .center
        self.numberOfLines = 0
    }
    
}
