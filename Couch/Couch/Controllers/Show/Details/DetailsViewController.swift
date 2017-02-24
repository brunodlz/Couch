import UIKit

enum Ep {
    case last, next
}

class DetailsViewController: UIViewController {
    
    weak var show: Show!
    weak var provider: DataProvider!
    
    let detailsView = DetailsView()
    let viewModel = DetailsViewModel()
    
    init(provider: DataProvider, show: Show) {
        self.provider = provider
        self.show = show
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailsView
        detailsView.nextEpisode.addTarget(self, action: #selector(showNextEpisode), for: .touchUpInside)
        
        self.title = show.title ?? ""
        self.view.backgroundColor = ColorPalette.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        show(episode: .last)
    }
    
    @objc private func showNextEpisode() {
        show(episode: .next)
    }
    
    private func show(episode: Ep) {
        if let imdb = self.show.imdb {
            self.didRequest()
            switch episode {
            case .last:
                self.lastEpisode(with: imdb)
                break
            case .next:
                self.nextEpisode(with: imdb)
                break
            }
            self.progress(with: imdb)
        }
    }
    
    private func nextEpisode(with imdb: String) {
        viewModel.nextEpisode(with: imdb, provider: provider) { (episode) in
            if let episode = episode {
                self.detailsView.show(episode: episode)
                self.detailsView.nextEpisode.isHidden = true
                self.episodeDetails(with: imdb,
                                    season: episode.season,
                                    episode: episode.number)
            }
        }
    }
    
    private func lastEpisode(with imdb: String) {
        viewModel.lastEpisode(with: imdb, provider: provider) { (episode) in
            if let episode = episode {
                self.detailsView.show(episode: episode)
                self.episodeDetails(with: imdb,
                                    season: episode.season,
                                    episode: episode.number)
            }
        }
    }
    
    private func episodeDetails(with imdb: String, season: Int?, episode: Int?) {
        viewModel.episodeDetails(with: imdb,
                                 season: season,
                                 episode: episode,
                                 provider: provider) { (episode) in
                                    guard let episode = episode else {
                                        self.showAlert("An error occurred. try again :(")
                                        return
                                    }
                                    self.detailsView.show(episode: episode)
                                    self.didUpdate()
        }
    }
    
    private func progress(with imdb: String) {
        viewModel.progress(with: imdb, provider: provider) { (episode) in
            guard let episode = episode else {
                self.showAlert("An error occurred. try again :(")
                return
            }
            self.detailsView.watched(progress: episode.progress)
        }
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
