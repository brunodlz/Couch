import Foundation

enum JsonError: Error {
    case message(String)
}

enum Result<T> {
    case success(T)
    case failure(JsonError)
}
