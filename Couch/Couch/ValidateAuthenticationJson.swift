import Foundation

struct ValidateAuthenticationJson {
    
    static func validate(data: RawData) -> Bool {
        guard let accessToken = data as? Dictionary<String,AnyObject> else { return false }
        guard let currentToken = accessToken["access_token"] as? String else { return false }
        KeysManager.setToken(currentToken)
        UserDefaults.standard.synchronize()
        return true
    }
    
}
