import Foundation
import ObjectMapper

class Profile: Mappable {
    var username: String?
    var name: String?
    var location: String?
    var joined_at: DateComponents?
    var avatar: String?
    var age: Int?
    var about: String?
    var slug: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        username  <- map["username"]
        name      <- map["name"]
        location  <- map["location"]
        joined_at <- map[""]
        about     <- map["about"]
        age       <- map["age"]
        avatar    <- map["images.avatar.full"]
        slug      <- map["ids.slug"]
    }
}
