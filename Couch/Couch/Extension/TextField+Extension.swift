import UIKit

class TextField: UITextField {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 15)
        
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
        
        self.tintColor = ColorPalette.white
        self.textColor = ColorPalette.white
    }
    
    func setPlaceHolder(with text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text,
                                                        attributes: [NSForegroundColorAttributeName:
                                                            UIColor.white.withAlphaComponent(0.5)])
    }
}
