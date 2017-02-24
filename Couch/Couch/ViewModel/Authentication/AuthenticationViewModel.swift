import Foundation

struct AuthenticationViewModel {
    
    func validateToken(with data: RawData) -> Bool {
        return ValidateAuthenticationJson.validate(data: data)
    }
    
}
