import Foundation

extension TraktAPI {
    static func to(_ url: URL?,
                   method: HTTPMethod,
                   authorization: Bool = false) -> URLRequest? {
        
        guard let url = url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let headers = TraktAPI.headerWithAuth()
        for (headerField, headerValue) in headers {
            urlRequest.setValue(headerValue, forHTTPHeaderField: headerField)
        }
        
        if authorization && KeysManager.getToken().characters.count > 0 {
            let token = KeysManager.getToken()
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
    
    static func headerWithAuth() -> [String:String] {
        return ["Content-Type": "application/json",
                "trakt-api-version": "2",
                "trakt-api-key": OAuth.clientID]
    }
}
