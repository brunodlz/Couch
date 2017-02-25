import Foundation
import ObjectMapper

struct ValidateDetailsJson {
    
    static func validate(Episode data: RawData) -> Episode? {
        guard let details = data as? [String:AnyObject] else { return nil }
        
        let episode = Mapper<Episode>().map(JSONObject: details)

        if let dateTime = details["first_aired"] as? String {
            episode?.aired = Date().convertDate(To: dateTime)
        }
        return episode
    }
    
    static func validate(Season data: RawData) -> [Season] {
        var allSeasons = [Season]()
        
        guard let details = data as? Array<AnyObject> else { return allSeasons }
        
        for info in details {
            if let season = Mapper<Season>().map(JSONObject: info) {
                allSeasons.append(season)
            }
        }
        return allSeasons
    }
}
