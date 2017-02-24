import Foundation
import ObjectMapper

public class DateFormatTransform: TransformType {
    
    public typealias Object = NSDate
    public typealias JSON = String
    
    var dateFormatter = DateFormatter()
    
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
    }
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let dateString = value as? String {
            return self.dateFormatter.date(from: dateString) as DateFormatTransform.Object?
        }
        return nil
    }
    public func transformToJSON(_ value: NSDate?) -> JSON? {
        if let date = value {
            return self.dateFormatter.string(from: date as Date)
        }
        return nil
    }
}
