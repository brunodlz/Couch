import UIKit
import SnapKit

final class AuthenticationView: UIView {
    
    let bannerImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "banner"))
        return image
    }()
    
    let iconImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "trakt"))
        return image
    }()

    let traktLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "T R A K T"
        label.textColor = ColorPalette.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    let pinTextField: UITextField = {
        let textField = TextField(frame: .zero)
        textField.setPlaceHolder(with: "Insert Your Pin")
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
        
        bannerImage.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.bottom.equalTo(self)
            make.right.equalTo(self)
        }
        
        iconImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(60)
            make.centerX.equalTo(self)
            make.width.equalTo(64)
            make.height.equalTo(64)
        }
        
        traktLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.bottom).offset(20)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(20)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(traktLabel.snp.bottom).offset(40)
            make.centerX.equalTo(iconImage.snp.centerX)
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
        
        self.bannerImage.addBlur()
        self.addSubview(bannerImage)
        self.addSubview(iconImage)
        self.addSubview(traktLabel)
    
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
