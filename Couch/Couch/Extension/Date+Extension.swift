import Foundation

enum FormatterDate: String {
    case server = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case day    = "yyyy/MM/dd"
}

extension Date {
    
    func convertDate(To string: String?) -> DateComponents? {
        guard let dateString = string else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormatterDate.server.rawValue
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        
        guard let endDate = dateFormatter.date(from: dateString) else { return nil }
        
        let cal = Calendar.current
        let unit:NSCalendar.Unit = NSCalendar.Unit(rawValue: UInt.max)
        return (cal as NSCalendar).components(unit, from: endDate)
    }
    
    func convertString(To dateComponents: DateComponents?, mask: FormatterDate) -> String {
        guard let dateComponents = dateComponents else { fatalError("dateComponents is nil") }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = mask.rawValue
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        let calendar = Calendar.current
        guard let date = calendar.date(from: dateComponents) else { fatalError("mask is incorrect") }
        return dateFormatter.string(from: date)
    }
    
}
