import Foundation

final class DataProvider {
    
    private let client: TraktClient
    
    init(client: TraktClient) {
        self.client = client
    }
    
    func token(With code: String, callback: @escaping TraktClosure) {
        let data : [String:String] = [
            "code"          : code,
            "client_id"     : OAuth.clientID,
            "client_secret" : OAuth.clientSecret,
            "redirect_uri"  : OAuth.redirectURI,
            "grant_type"    : "authorization_code"]
        
        do {
            try client.token(data, callback: { (result) in
                callback(result)
            })
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
    
    func shows(callback: @escaping TraktClosure) {
        let slug = KeysManager.getUser()
        client.shows(withUser: slug) { (result) in
            callback(result)
        }
    }
    
    func progress(_ imdb: String, callback: @escaping TraktClosure) {
        client.progress(imdb) { (result) in
            callback(result)
        }
    }
    
    func nextEpisode(_ imdb: String, callback: @escaping TraktClosure) {
        client.nextEpisode(imdb) { (result) in
            callback(result)
        }
    }
    
    func lastEpisode(_ imdb: String, callback: @escaping TraktClosure) {
        client.lastEpisode(imdb) { (result) in
            callback(result)
        }
    }
    
    func episodeDetails(_ imdb: String, season: Int, episode: Int, callback: @escaping TraktClosure) {
        do {
            try client.episodeDetails(imdb, season: season, episode: episode, callback: { (result) in
                callback(result)
            })
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
    
    func profile(callback: @escaping TraktClosure) {
        client.profile { (result) in
            callback(result)
        }
    }
    
}
