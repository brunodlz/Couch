import Foundation
import ObjectMapper

class Show: Mappable {
    var title: String?
    var listed_at: String?
    var imdb: String?
    var slug: String?
    var tmdb: String?
    var trakt: String?
    var year: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        title     <- map["title"]
        listed_at <- map[""]
        imdb      <- map["ids.imdb"]
        slug      <- map["ids.slug"]
        tmdb      <- map["ids.tmdb"]
        trakt     <- map["ids.trakt"]
        year      <- map["year"]
    }
}
