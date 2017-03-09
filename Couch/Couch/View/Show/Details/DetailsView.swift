import UIKit
import SnapKit

class DetailsView: UIView {
    
    func show(episode: Episode) {
        if let season = episode.season, let number = episode.number {
            self.seasonLabel.text = "SEASON \(season)"
            self.episodeLabel.text = "EPISODE \(number)"
        }
        self.overviewTextView.text = episode.overview ?? ""
        let date = Date().convertString(To: episode.aired, mask: .day)
        self.airedLabel.text = "Aired: \(date)"
        ImageManager().download(with: episode.imdb, imageView: episodeImage)
    }
    
    let episodeImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    let previousButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(.previous(), for: .normal)
        return button
    }()
    
    let seasonLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.textColor = ColorPalette.white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let separatorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "•"
        label.textAlignment = .center
        label.textColor = ColorPalette.white
        return label
    }()

    let episodeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = ColorPalette.white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(.next(), for: .normal)
        return button
    }()
    
    let airedLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.white
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.textColor = ColorPalette.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "unfavorite"), for: .normal)
        return button
    }()
    
    let overviewTextView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.isSelectable = false
        text.backgroundColor = .clear
        text.textColor = ColorPalette.white
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsView: ViewConfiguration {
    
    func setupConstraints() {
        episodeImage.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(120)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(episodeImage.snp.bottom).offset(8)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-8)
            make.height.equalTo(30)
        }
        
        airedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(20)
        }
        
        overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(airedLabel.snp.bottom).offset(8)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(favoriteButton.snp.left).offset(-2)
            make.height.equalTo(20)
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.top.equalTo(airedLabel.snp.bottom).offset(4)
            make.right.equalTo(self).offset(-20)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        overviewTextView.snp.makeConstraints { (make) in
            make.top.equalTo(overviewLabel.snp.bottom)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-8)
            make.bottom.equalTo(self).offset(-4)
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(episodeImage)
        
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(seasonLabel)
        stackView.addArrangedSubview(separatorLabel)
        stackView.addArrangedSubview(episodeLabel)
        stackView.addArrangedSubview(nextButton)
        self.addSubview(stackView)
        
        self.addSubview(airedLabel)
        self.addSubview(overviewLabel)
        self.addSubview(favoriteButton)
        self.addSubview(overviewTextView)
    }
    
    func configureViews() {
        previousButton.clipsToBounds = true
        previousButton.layer.cornerRadius = 12
        
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 12
    }
}
