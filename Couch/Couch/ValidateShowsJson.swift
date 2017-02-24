import Foundation
import ObjectMapper

struct ValidateShowsJson {
    
    static func validate(data: RawData) -> [Show] {
        var watchings = [Show]()
        
        guard let shows = data as? Array<[String:AnyObject]> else {
            return watchings
        }
        
        for info in shows {
            guard let details = info["show"] as? [String:AnyObject] else {
                continue
            }
            if let show = Mapper<Show>().map(JSONObject: details) {
                watchings.append(show)
            }
        }
        
        return watchings
    }
    
}
