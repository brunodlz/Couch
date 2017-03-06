import Foundation
import ObjectMapper

struct ValidatePopularJson {
    
    static func validate(data: RawData) -> [Show] {
        var movies = [Show]()
        
        guard let populares = data as? Array<[String:AnyObject]> else {
            return movies
        }
        
        for item in populares {
            if let objc = Mapper<Show>().map(JSONObject: item) {
                movies.append(objc)
            }
        }
        
        return movies
    }
    
}
