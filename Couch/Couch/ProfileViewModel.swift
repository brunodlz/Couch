import Foundation

struct ProfileViewModel {
    
    func getProfile(_ provider: DataProvider,
                    callback: @escaping (Profile?) ->()) -> () {
        provider.profile { (result) in
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
    
    private func validate(with data: RawData) -> Profile? {
        return ValidateProfileJson.validate(data: data)
    }
}
