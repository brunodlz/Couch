import UIKit

enum Ep {
    case first, previous, next
}

class DetailsViewController: UIViewController {
    
    var show: Show!
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
        detailsView.previousButton.addTarget(self, action: #selector(showPreviousEpisode), for: .touchUpInside)
        detailsView.nextButton.addTarget(self, action: #selector(showNextEpisode), for: .touchUpInside)
        
        self.title = show.title ?? ""
        self.view.backgroundColor = ColorPalette.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let imdb = self.show.imdb {
            self.didRequest()
            self.allSeasons(with: imdb)
        }
    }
    
    @objc private func showPreviousEpisode() {
        if let imdb = self.show.imdb {
            self.didRequest()
            self.episodeDetails(with: imdb, ep: .previous)
        }
    }
    
    @objc private func showNextEpisode() {
        if let imdb = self.show.imdb {
            self.didRequest()
            self.episodeDetails(with: imdb, ep: .next)
        }
    }
    
    private func allSeasons(with imdb: String) {
        viewModel.allSeasons(with: imdb, provider: provider) { (result) in
            if result.count > 0 {
                self.episodeDetails(with: imdb, ep: .first)
            }
        }
    }
    
    private func episodeDetails(with imdb: String, ep: Ep) {
        viewModel.episodeDetails(with: imdb, provider: provider, episode: ep) { (episode) in
            guard let episode = episode else {
                self.showAlert("An error occurred. try again :(")
                return
            }
            self.detailsView.show(episode: episode)
            self.didUpdate()
        }
    }
    
    private func progress(with imdb: String) {
//        viewModel.progress(with: imdb, provider: provider) { (episode) in
//            guard let episode = episode else {
//                self.showAlert("An error occurred. try again :(")
//                return
//            }
//            self.detailsView.watched(progress: episode.progress)
//        }
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
