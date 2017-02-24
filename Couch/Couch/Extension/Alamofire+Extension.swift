import Foundation
import Alamofire

open class Service: NSObject {
    
    class func request(with router: URLRequest,
                       callback: @escaping TraktClosure) -> () {
        Alamofire.request(router).responseJSON { response in
            switch response.result {
            case .success(let data):
                callback(.success(data))
                break
            case .failure(let error):
                callback(.failure(.message("\(error.localizedDescription)")))
                break
            }
        }
    }
    
}
