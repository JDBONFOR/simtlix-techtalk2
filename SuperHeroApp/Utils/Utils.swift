import Foundation

class Utils: NSObject {
    
    enum ResourceType {
        case allHeroes
        case hero(id: Int)
        
        var endpoint: String {
            switch self {
            case .allHeroes:
                return Constants.EndpointKeys.heroes
            case .hero(_):
                return Constants.EndpointKeys.hero
            }
        }
    }
        
    // Endpoint.plist
    public static func getEndpoints() -> [String: Any]? {
        guard let path = Bundle.main.path(forResource: Constants.EndpointDictionary, ofType: Constants.EndpointExtension),
              let dictionary = NSDictionary(contentsOfFile: path),
              let result = dictionary as? [String: Any] else { return nil }
        return result
    }
    
    public static func getResource(resourceType: ResourceType) -> String? {
        guard let endpoints = Utils.getEndpoints(),
              let endpointsData = endpoints[resourceType.endpoint] as? [String: Any],
              let urlString = endpointsData[Constants.EndpointKeys.url] as? String else { return nil }
        
        var urlFormatted = ""
        switch resourceType {
        case .allHeroes:
            urlFormatted = String(format: urlString, arguments: ["all.json"])
        case .hero(let id):
            urlFormatted = String(format: urlString, arguments: [String(id)])
        }
        return Constants.baseUrl + urlFormatted
    }
    
    // Date formatter
    public static func formateDate(_ date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMMM yyyy"

        if let newDate = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: newDate)
        }
        return ""
    }
}
