import UIKit
import SnapKit
import AlamofireImage

final class ProfileView: UIView {
    
    func setup(_ profile: Profile) {
        usernameLabel.text = profile.name
        avatarImage.af_setImage(withURL: URL(string: profile.avatar!)!)
        let date = Date().convertString(To: profile.joined_at, mask: .day)
        memberSinceLabel.text = "Member since: \(date)"
        aboutLabel.text = profile.about
        locationLabel.text = profile.location
        ageLabel.text = "\(profile.age!) years old"
    }

    let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.layer.borderColor = ColorPalette.white.cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = ColorPalette.white
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightMedium)
        return label
    }()
    
    let avatarImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        return image
    }()
    
    let memberSinceLabel: Label = {
        let label = Label()
        return label
    }()
    
    let aboutLabel: Label = {
        let label = Label()
        return label
    }()
    
    let locationLabel: Label = {
        let label = Label()
        return label
    }()
    
    let ageLabel: Label = {
        let label = Label()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboard ugh :P")
    }
}

extension ProfileView: ViewConfiguration {
    func setupConstraints() {
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-8)
            make.bottom.equalTo(self).offset(-8)
        }
//        
//        usernameLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(self).offset(20)
//            make.left.equalTo(self)
//            make.right.equalTo(self)
//            make.height.equalTo(22)
//        }
//        
//        avatarImage.snp.makeConstraints { (make) in
//            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
//            make.centerX.equalTo(self)
//            make.width.equalTo(120)
//            make.height.equalTo(120)
//        }
//        
//        memberSinceLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(avatarImage.snp.bottom).offset(8)
//            make.left.equalTo(self).offset(32)
//            make.right.equalTo(self).offset(-32)
//        }
//        
//        aboutLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(memberSinceLabel.snp.bottom).offset(8)
//            make.left.equalTo(self).offset(32)
//            make.right.equalTo(self).offset(-32)
//        }
//        
//        locationLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(aboutLabel.snp.bottom).offset(8)
//            make.left.equalTo(self).offset(32)
//            make.right.equalTo(self).offset(-32)
//        }
//        
//        ageLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(locationLabel.snp.bottom).offset(8)
//            make.left.equalTo(self).offset(32)
//            make.right.equalTo(self).offset(-32)
//        }
    }
    
    func buildViewHierarchy() {
//        self.addSubview(usernameLabel)
//        self.addSubview(avatarImage)
//        self.addSubview(memberSinceLabel)
//        self.addSubview(aboutLabel)
//        self.addSubview(locationLabel)
//        self.addSubview(ageLabel)
        
        self.addSubview(containerView)
    }
    
    func configureViews() {
        avatarImage.clipsToBounds      = true
        avatarImage.layer.cornerRadius = 60
        avatarImage.layer.borderWidth  = 2
        avatarImage.layer.borderColor  = ColorPalette.white.cgColor
    }
}
