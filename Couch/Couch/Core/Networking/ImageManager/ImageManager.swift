import Foundation
import Alamofire
import AlamofireImage

final class ImageManager {
    
    func download(with id: String?, imageView: UIImageView) {
        
        guard let id = id else { return }
        
        Alamofire.request("\(OmdbAPI.url)?i=\(id)&plot=short&r=json").responseJSON { response in
            if let json = response.result.value as? [String:AnyObject] {
                guard let poster = json["Poster"] as? String else { return }
                guard let url = URL(string: poster) else { return }
                
                imageView.image = nil
                imageView.af_setImage(withURL: url)
            }
        }
    }
    
}
