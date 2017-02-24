import Foundation
import ObjectMapper

struct ValidateDetailsJson {
    
    static func validate(data: RawData) -> Episode? {
        guard let details = data as? [String:AnyObject] else { return nil }
        guard let nextEpisode = details["next_episode"] as? [String:AnyObject] else {
            return Mapper<Episode>().map(JSONObject: details)
        }
        guard let episode = Mapper<Episode>().map(JSONObject: nextEpisode) else {
            return nil
        }
        if let aired = details["aired"] as? Int, let completed = details["completed"] as? Int {
            episode.progress = (completed > 0) ? ((100 * completed) / aired) : 0
        }
        return episode
    }
    
}
