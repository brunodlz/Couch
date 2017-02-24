import UIKit
import SnapKit

class ShowView: UIView {
    
    let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = ColorPalette.black
        return view
    }()
    
    let banner: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.backgroundColor = ColorPalette.blue
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        label.textColor = ColorPalette.white
        label.numberOfLines = 0
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = ColorPalette.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShowView: ViewConfiguration {
    func setupConstraints() {
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        banner.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(4)
            make.left.equalTo(self).offset(16)
            make.bottom.equalTo(self).offset(-4)
            make.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(banner.snp.top)
            make.left.equalTo(banner.snp.right).offset(8)
            make.right.equalTo(self).offset(-4)
        }
        
        yearLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(titleLabel.snp.right)
        }
    }
    
    func buildViewHierarchy() {
        
        containerView.addSubview(banner)
        containerView.addSubview(titleLabel)
        containerView.addSubview(yearLabel)
        
        self.addSubview(containerView)
    }
    
    func configureViews() {
        banner.clipsToBounds = true
        banner.layer.borderWidth = 0.5
        banner.layer.cornerRadius = 4
        banner.layer.borderColor = ColorPalette.gray.cgColor
    }
}
