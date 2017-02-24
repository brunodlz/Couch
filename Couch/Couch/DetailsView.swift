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
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
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
    
    let overviewTextView: UITextView = {
        let text = UITextView()
        text.backgroundColor = .clear
        text.textColor = ColorPalette.white
        return text
    }()
    
    let nextEpisode: UIButton = {
        let button = UIButton()
        button.setTitle("Next Episode", for: .normal)
        button.setTitleColor(ColorPalette.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
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
        
        overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(seasonAndEpisodeLabel.snp.bottom).offset(8)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
            make.height.equalTo(20)
        }
        
        progressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(overviewLabel.snp.top)
            make.left.equalTo(overviewLabel.snp.right).offset(2)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(20)
        }
        
        overviewTextView.snp.makeConstraints { (make) in
            make.top.equalTo(overviewLabel.snp.bottom)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-8)
            make.bottom.equalTo(nextEpisode.snp.top).offset(-4)
        }
        
        nextEpisode.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-8)
            make.height.equalTo(40)
            make.bottom.equalTo(self).offset(-4)
        }
        
    }
    
    func buildViewHierarchy() {
        self.addSubview(episodeImage)
        self.addSubview(seasonAndEpisodeLabel)
        self.addSubview(overviewLabel)
        self.addSubview(progressLabel)
        self.addSubview(overviewTextView)
        self.addSubview(nextEpisode)
    }
    
    func configureViews() {
        nextEpisode.clipsToBounds = true
        nextEpisode.layer.cornerRadius = 12
    }
}
