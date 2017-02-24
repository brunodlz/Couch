import Foundation

public enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
}

struct OAuth {
    static let url           = "https://api.trakt.tv"
    static let clientID      = "1a611bba8dcd8b33aa53911c92455a1f2cc950dd578a2024e0613cf13fe69b4f"
    static let clientSecret  = "46b06c01513f9282e803dd9b2a152e4d05a0386635e916727260c1c5c78294ec"
    static let redirectURI   = "urn:ietf:wg:oauth:2.0:oob"
    static let authorization = "\(OAuth.url)/oauth/authorize/"
        + "?client_id=" + OAuth.clientID
        + "&redirect_uri=" + OAuth.redirectURI
        + "&response_type=code"
}

final class TraktAPI {
    
    enum Endpoints {
        case token
        case profile
        case shows(String)
        case progress(String)
        case nextEpisode(String)
        case lastEpisode(String)
        case episodeDetails(String,Int,Int)
        
        func url() -> String {
            switch self {
            case .token:
                return "\(OAuth.url)/oauth/token"
                
            case .profile:
                return "\(OAuth.url)/users/settings"
                
            case .shows(let user):
                return "\(OAuth.url)/users/\(user)/watchlist/shows"
                
            case .progress(let imdb):
                return "\(OAuth.url)/shows/\(imdb)/progress/watched"
                
            case .nextEpisode(let imdb):
                return "\(OAuth.url)/shows/\(imdb)/next_episode"
                
            case .lastEpisode(let imdb):
                return "\(OAuth.url)/shows/\(imdb)/last_episode"
                
            case .episodeDetails(let imdb, let season, let episode):
                return "\(OAuth.url)/shows/\(imdb)/seasons/\(season)/episodes/\(episode)"
            }
        }
    }
    
    func token() -> URLRequest? {
        let endPoint = URL(string: TraktAPI.Endpoints.token.url())
        return TraktAPI.to(endPoint, method: .post, authorization: true)
    }
    
    func profile() -> URLRequest? {
        let endPoint = URL(string: TraktAPI.Endpoints.profile.url())
        return TraktAPI.to(endPoint, method: .get, authorization: true)
    }
    
    func shows(_ user: String) -> URLRequest? {
        let endPoint = URL(string: TraktAPI.Endpoints.shows(user).url())
        return TraktAPI.to(endPoint, method: .get)
    }
    
    func progress(_ imdb: String) -> URLRequest? {
        let endPoint = URL(string: TraktAPI.Endpoints.progress(imdb).url())
        return TraktAPI.to(endPoint, method: .get, authorization: true)
    }
    
    func nextEpisode(_ imdb: String) -> URLRequest? {
        let endPoint = URL(string: TraktAPI.Endpoints.nextEpisode(imdb).url())
        return TraktAPI.to(endPoint, method: .get)
    }
    
    func lastEpisode(_ imdb: String) -> URLRequest? {
        let endPoint = URL(string: TraktAPI.Endpoints.lastEpisode(imdb).url())
        return TraktAPI.to(endPoint, method: .get)
    }
    
    func episodeDetails(_ imdb: String, season: Int, episode: Int) -> URLRequest? {
        let endPoint = URL(string: TraktAPI.Endpoints.episodeDetails(imdb, season, episode).url())
        return TraktAPI.to(endPoint, method: .get)
    }
}

extension TraktAPI {
    
    static fileprivate func to(_ url: URL?,
                               method: HTTPMethod,
                               authorization: Bool = false) -> URLRequest? {
        
        guard let url = url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let headers = TraktAPI.headerWithAuth()
        for (headerField, headerValue) in headers {
            urlRequest.setValue(headerValue, forHTTPHeaderField: headerField)
        }
        
        if authorization && KeysManager.getToken().characters.count > 0 {
            let token = KeysManager.getToken()
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
    
    static func headerWithAuth() -> [String:String] {
        return ["Content-Type": "application/json",
                "trakt-api-version": "2",
                "trakt-api-key": OAuth.clientID]
    }
    
}
