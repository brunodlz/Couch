import Foundation

struct ShowViewModel {
    
    func watching(_ provider: DataProvider, callback: @escaping ([Show]) -> ()) -> () {
        provider.shows { (result) in
            switch result {
            case .success(let data):
                callback(self.validate(with: data))
                break
            case .failure(let error):
                print("\(error.localizedDescription)")
                break
            }
        }
    }
    
    func popular(_ provider: DataProvider, callback: @escaping ([Show]) -> ()) -> () {
        provider.popular { (result) in
            switch result {
            case .success(let data):
                callback(self.validateMovies(with: data))
                break
                
            case .failure(let error):
                print("\(error.localizedDescription)");
                break
            }
        }
    }
    
    private func validate(with data: RawData) -> [Show] {
        return ValidateShowsJson.validate(data: data)
    }
    
    private func validateMovies(with data: RawData) -> [Show] {
        return ValidatePopularJson.validate(data: data)
    }
}
