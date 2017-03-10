import Foundation
import ObjectMapper

class Connection: Mappable {
    
    var facebook: Bool?
    var twitter: Bool?
    var google: Bool?
    var tumblr: Bool?
    var medium: Bool?
    var slack: Bool?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        facebook <- map["facebook"]
        twitter  <- map["twitter"]
        google   <- map["google"]
        tumblr   <- map["tumblr"]
        medium   <- map["medim"]
        slack    <- map["slack"]
    }
    
}
