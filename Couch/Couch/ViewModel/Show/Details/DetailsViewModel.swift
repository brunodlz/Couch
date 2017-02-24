import Foundation

typealias EpisodeClosure = (Episode?) -> ()

class DetailsViewModel {
    
    func nextEpisode(with imdb: String,
                     provider: DataProvider,
                     callback: @escaping EpisodeClosure) -> () {
        
        provider.nextEpisode(imdb, callback: { (result) in
            switch result {
            case .success(let data):
                callback(self.validate(with: data))
                break
            case .failure(let error):
                print("\(error.localizedDescription)")
                callback(nil)
                break
            }
        })
    }
    
    func lastEpisode(with imdb: String,
                     provider: DataProvider,
                     callback: @escaping EpisodeClosure) -> () {
        
        provider.lastEpisode(imdb, callback: { (result) in
            switch result {
            case .success(let data):
                callback(self.validate(with: data))
                break
            case .failure(let error):
                print("\(error.localizedDescription)")
                callback(nil)
                break
            }
        })
    }
    
    func episodeDetails(with imdb: String,
                        season: Int?,
                        episode: Int?,
                        provider: DataProvider,
                        callback: @escaping EpisodeClosure) -> () {
        
        guard let season = season, let episode = episode else { return callback(nil) }
        
        provider.episodeDetails(imdb, season: season, episode: episode) { (result) in
            switch result {
            case .success(let data):
                callback(self.validate(with: data))
                break
            case .failure(let error):
                print("\(error.localizedDescription)")
                callback(nil)
                break
            }
        }
    }
    
    func progress(with imdb: String,
                  provider: DataProvider,
                  callback: @escaping EpisodeClosure) -> () {
        
        provider.progress(imdb, callback: { (result) in
            switch result {
            case .success(let data):
                callback(self.validate(with: data))
                break
            case .failure(let error):
                print("\(error.localizedDescription)")
                callback(nil)
                break
            }
        })
    }
    
    private func validate(with data: RawData) -> Episode? {
        return ValidateDetailsJson.validate(data: data)
    }
}
