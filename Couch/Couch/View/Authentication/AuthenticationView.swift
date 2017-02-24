import UIKit
import SnapKit

final class AuthenticationView: UIView {
    
    let containerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    let pinTextField: UITextField = {
        let textField = TextField()
        textField.setPlaceHolder(with: "Insert Your Pin")
        textField.addDoneButtonOnKeyboard()
        return textField
    }()
    
    let connectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Connect", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = ColorPalette.green
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        return button
    }()
    
    let getPinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Pin", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 12)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboard ugh :P")
    }
}

extension AuthenticationView: ViewConfiguration {
    func setupConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(152)
        }
        
        pinTextField.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(0)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
            make.height.equalTo(40)
        }
        
        connectButton.snp.makeConstraints { (make) in
            make.top.equalTo(pinTextField.snp.bottom).offset(16)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
            make.height.equalTo(40)
        }
        
        getPinButton.snp.makeConstraints { (make) in
            make.top.equalTo(connectButton.snp.bottom).offset(16)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
            make.height.equalTo(40)
        }
    }
    
    func buildViewHierarchy() {
        containerView.addSubview(pinTextField)
        containerView.addSubview(connectButton)
        containerView.addSubview(getPinButton)
        
        self.addSubview(containerView)
    }
    
    func configureViews() {
        self.pinTextField.keyboardAppearance     = .dark
        self.pinTextField.returnKeyType          = .done
        self.pinTextField.autocapitalizationType = .allCharacters
        self.pinTextField.layer.borderColor      = ColorPalette.green.cgColor
    }
}
