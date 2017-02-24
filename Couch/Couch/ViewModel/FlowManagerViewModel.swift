import Foundation

final class FlowManagerViewModel {
    
    func isLoggedIn() -> Bool {
        guard KeysManager.getToken().isEmpty else {
            return true
        }
        return false
    }
    
}
