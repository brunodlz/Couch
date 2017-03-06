import Foundation
import ObjectMapper

struct ValidateProfileJson {
    
    static func validate(data: RawData) -> Profile? {
        guard let settings = data as? [String: AnyObject] else { return nil }
        guard let info = settings["user"] as? [String: AnyObject] else { return nil}
        
        let profile = Mapper<Profile>().map(JSONObject: info)
        
        if let dateTime = info["joined_at"] as? String {
            profile?.joined_at = Date().convertDate(To: dateTime)
        }
        
        if let slug = profile?.slug {
            KeysManager.setUser(slug)
            UserDefaults.standard.synchronize()
        }
        return profile
    }
    
}
