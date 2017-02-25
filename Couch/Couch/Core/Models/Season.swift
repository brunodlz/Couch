import Foundation
import ObjectMapper

class Season: Mappable {
    var number: Int?
    var trakt: String?
    var tvdb: String?
    var tmdb: String?
    var tvrage: String?
    var episodes: [Episode]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        number   <- map["number"]
        trakt    <- map["ids.trakt"]
        tvdb     <- map["ids.tvdb"]
        tmdb     <- map["ids.tmdb"]
        tvrage   <- map["ids.tvrage"]
        episodes  <- map["episodes"]
    }
}
