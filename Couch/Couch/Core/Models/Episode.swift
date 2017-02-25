import Foundation
import ObjectMapper

class Episode: Mappable {
    var season: Int?
    var number: Int?
    var title: String?
    var imdb: String?
    var slug: String?
    var tmdb: String?
    var trakt: String?
    var aired: DateComponents?
    var overview: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        season   <- map["season"]
        number   <- map["number"]
        title    <- map["title"]
        imdb     <- map["ids.imdb"]
        slug     <- map["ids.slug"]
        tmdb     <- map["ids.tmdb"]
        trakt    <- map["ids.trakt"]
        aired    <- map[""]
        overview <- map["overview"]
    }
}
