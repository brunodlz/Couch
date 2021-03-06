import Foundation

typealias SeasonClosure  = ([Season]) -> ()
typealias EpisodeClosure = (Episode?) -> ()

class DetailsViewModel {
    
    var seasons = [Season]()
    var allSeasons = 0
    var allEpisodes = 0
    var currentSeason = 1
    var currentEpisode = 0
    
    func allSeasons(with imdb: String,
                    provider: DataProvider,
                    callback: @escaping SeasonClosure) -> () {
        
        
        provider.allSeasons(imdb) { (result) in
            switch result {
            case .success(let data):
                callback(self.validateSeason(with: data))
                break
            case .failure(let error):
                print("\(error.localizedDescription)")
//                callback(nil)
                break
            }
        }
    }
    
    func episodeDetails(with imdb: String,
                        provider: DataProvider,
                        episode: Ep,
                        callback: @escaping EpisodeClosure) -> () {

        let ep = getCurrent(episode)
        provider.episodeDetails(imdb, season: currentSeason, episode: ep) { (result) in
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
    
    private func getCurrent(_ episode: Ep) -> Int {
        switch episode {
        case .first, .next:
            return self.nextEpisode
        case .previous:
            return self.previousEpisode
        }
    }
    
    private var previousEpisode: Int {
        guard currentEpisode == 1 else {
            currentEpisode -= 1
            return currentEpisode
        }
        if currentSeason > 1 {
            currentSeason -= 1
            
            currentEpisode = getAllEpisodes()
        }
        return currentEpisode
    }
    
    private var nextEpisode: Int {
        allEpisodes = getAllEpisodes()
        if currentEpisode == allEpisodes {
            if containsNextSeason() {
                setSeason()
                currentEpisode = 1
                return currentEpisode
            }
            return currentEpisode
        }
        currentEpisode += 1
        return currentEpisode
    }
    
    private func setSeason() {
        currentSeason += 1
    }
    
    private func getAllEpisodes() -> Int {
        guard let episodes : [Episode] = seasons[currentSeason].episodes else {
            return 0
        }
        return episodes.count
    }
    
    private func containsNextSeason() -> Bool {
        if currentSeason < allSeasons {
            return true
        }
        return false
    }

    private func validate(with data: RawData) -> Episode? {
        return ValidateDetailsJson.validate(Episode: data)
    }
    
    private func validateSeason(with data: RawData) -> [Season] {
        self.seasons = ValidateDetailsJson.validate(Season: data)
        self.allSeasons = self.seasons.count - 1
        return self.seasons
    }
}
