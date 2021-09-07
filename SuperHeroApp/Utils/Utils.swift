import Foundation

class Utils: NSObject {
        
    // Endpoint.plist
    public static func getEndpoints() -> [String: Any]? {
        guard let path = Bundle.main.path(forResource: Constants.EndpointDictionary, ofType: Constants.EndpointExtension) else {
            return nil
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) else {
            return nil
        }
        guard let result = dictionary as? [String: Any] else {
            return nil
        }
        return result
    }
    
    // Date formatter
    public static func formateDate(_ date: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMMM yyyy"

        if let newDate = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: newDate)
        } else {
            return ""
        }
    }
}
