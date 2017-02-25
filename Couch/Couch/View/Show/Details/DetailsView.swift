import UIKit
import SnapKit

class DetailsView: UIView {
    
    func watched(progress: Int?) {
        if let progress = progress {
            self.progressLabel.text = "Watched: \(progress)%"
        }
    }
    
    func show(episode: Episode) {
        if let season = episode.season, let number = episode.number {
            self.seasonAndEpisodeLabel.text = "SEASON \(season) • EPISODE \(number)"
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
    
    let seasonAndEpisodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    let airedLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.white
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.white
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textAlignment = .right
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
    
    let overviewTextView: UITextView = {
        let text = UITextView()
        text.backgroundColor = .clear
        text.textColor = ColorPalette.white
        return text
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(ColorPalette.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        button.backgroundColor = ColorPalette.white
        return button
    }()
    
    let previousButton: UIButton = {
        let button = UIButton()
        button.setTitle("Previous", for: .normal)
        button.setTitleColor(ColorPalette.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        button.backgroundColor = ColorPalette.white
        return button
    }()
    
    let markAsWatchedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Watched", for: .normal)
        button.setTitleColor(ColorPalette.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        button.backgroundColor = ColorPalette.white
        return button
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
        
        seasonAndEpisodeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(episodeImage.snp.bottom).offset(8)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(20)
        }
        
        airedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(seasonAndEpisodeLabel.snp.bottom)
            make.width.equalTo(UIScreen.main.bounds.width/2)
            make.left.equalTo(self).offset(10)
            make.height.equalTo(20)
        }
        
        progressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(seasonAndEpisodeLabel.snp.bottom)
            make.left.equalTo(airedLabel.snp.right).offset(2)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(20)
        }
        
        overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(airedLabel.snp.bottom).offset(8)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(20)
        }
        
        overviewTextView.snp.makeConstraints { (make) in
            make.top.equalTo(overviewLabel.snp.bottom)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-8)
            make.bottom.equalTo(previousButton.snp.top).offset(-4)
        }
        
        previousButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(8)
            make.height.equalTo(30)
            make.width.equalTo(UIScreen.main.bounds.width/2)
            make.bottom.equalTo(self).offset(-4)
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-8)
            make.height.equalTo(30)
            make.width.equalTo(UIScreen.main.bounds.width/2)
            make.bottom.equalTo(self).offset(-4)
        }
    }
    
    func buildViewHierarchy() {
        self.addSubview(episodeImage)
        self.addSubview(seasonAndEpisodeLabel)
        self.addSubview(overviewLabel)
        self.addSubview(airedLabel)
        self.addSubview(progressLabel)
        self.addSubview(overviewTextView)
        self.addSubview(previousButton)
        self.addSubview(nextButton)
        self.addSubview(markAsWatchedButton)
    }
    
    func configureViews() {
        previousButton.clipsToBounds = true
        previousButton.layer.cornerRadius = 12
        
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 12
    }
}
