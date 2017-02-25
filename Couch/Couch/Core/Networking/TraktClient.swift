import Foundation

final class TraktClient {
    
    private let traktApi = TraktAPI()
    
    func token(_ json: [String:String], callback: @escaping TraktClosure) throws {
        guard var endPoint = traktApi.token() else {
            callback(.failure(.message("unknown url")))
            return
        }
        endPoint.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        
        Service.request(with: endPoint) { (result) in
            callback(result)
        }
    }
    
    func profile(callback: @escaping TraktClosure) {
        guard let endPoint = traktApi.profile() else {
            callback(.failure(.message("unknown url")))
            return
        }
        Service.request(with: endPoint) { (result) in
            callback(result)
        }
    }
    
    func shows(withUser user: String, callback: @escaping TraktClosure) {
        guard let endPoint = traktApi.shows(user) else {
            callback(.failure(.message("unknown url")))
            return
        }
        Service.request(with: endPoint) { (result) in
            callback(result)
        }
    }
    
    func progress(_ imdb: String, callback: @escaping TraktClosure) {
        guard let endPoint = traktApi.progress(imdb) else {
            callback(.failure(.message("unknown url")))
            return
        }
        Service.request(with: endPoint) { (result) in
            callback(result)
        }
    }
    
    func allSeasons(_ imdb: String, callback: @escaping TraktClosure) {
        guard let endPoint = traktApi.allSeasons(imdb) else {
            callback(.failure(.message("unknown url")))
            return
        }
        Service.request(with: endPoint) { (result) in
            callback(result)
        }
    }

    func episodeDetails(_ imdb: String, season: Int, episode: Int, callback: @escaping TraktClosure) throws {
        guard var endPoint = traktApi.episodeDetails(imdb, season: season, episode: episode) else {
            callback(.failure(.message("unknown url")))
            return
        }
        endPoint.httpBody = try JSONSerialization.data(withJSONObject: ["extended":"full"], options: [])
        Service.request(with: endPoint) { (result) in
            callback(result)
        }
    }
}
