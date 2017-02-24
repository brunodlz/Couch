import Foundation

enum UserDefaultKeys: String {
    case accessToken  = "accessToken"
    case refreshToken = "refreshToken"
    case username     = "username"
}

final class KeysManager {
    
    static func setToken(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: UserDefaultKeys.accessToken.rawValue)
    }
    
    static func getToken() -> String {
        guard let token: String = UserDefaults.standard.value(forKey: UserDefaultKeys.accessToken.rawValue) as? String else {
            return ""
        }
        return token
    }
    
    static func removeToken() {
        UserDefaults.standard.setValue("", forKey: UserDefaultKeys.accessToken.rawValue)
    }
    
    static func setUser(_ username: String) {
        UserDefaults.standard.setValue(username, forKey: UserDefaultKeys.username.rawValue)
    }
    
    static func getUser() -> String {
        guard let user: String = UserDefaults.standard.value(forKey: UserDefaultKeys.username.rawValue) as? String else {
            return ""
        }
        return user
    }
}
