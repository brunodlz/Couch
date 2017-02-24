import Foundation

typealias RawData = Any
typealias TraktClosure = (TraktCallback) -> ()

enum TraktCallback {
    case success(RawData)
    case failure(JsonError)
}
