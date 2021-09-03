
import SwiftUI
import Alamofire

final class NetworkingProvider {
    static let shared = NetworkingProvider()
    
    // GetData
    func fetchData<T: Codable>(url: String, callback: @escaping (T?, Error?) -> Void) {
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<409)
            .prettyPrintedJsonResponse()
            .responseDecodable(of: T.self) { response in
                
                if let response = response.value {
                    callback(response, nil)
                } else if let error = response.error {
                    
                    if let data: ErrorModel = try? JSONDecoder().decode(ErrorModel.self, from: response.data!) {
                        callback(nil, NSError(domain: data.status, code: data.code, userInfo: nil))
                    } else {
                        callback(nil, error)
                    }
                }
            }
    }
    
    func loadHeroesJson() -> HeroesResponse? {
        if let json = self.readLocalFile(forName: "heroes"),
           let data = self.parse(jsonData: json) {
            return data
        }
        return nil
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) -> HeroesResponse? {
        do {
            let decodedData = try JSONDecoder().decode(HeroesResponse.self,
                                                       from: jsonData)
            print("===================================")
            return decodedData
        } catch {
            print("decode error")
            return nil
        }
    }
}

struct RequestResponseWrapperModel<T:Codable>: Codable {
    let code: Int
    let status: String
    let data: T
    
    private enum CodingKeys: String, CodingKey {
        case code
        case status
        case data
    }
}

struct RequestResponseDataWrapperModel<T:Codable>: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
    
    private enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}

struct ErrorModel: Codable {
    let code: Int
    let status: String
}

public class Constants {
//    static let EndpointDictionary = "Endpoints"
//    static let EndpointExtension = "plist"
    
    static let accessToken = "5921820017859299"
    static let baseUrl = "https://superheroapi.com/api/\(accessToken)/"
    
    struct EndpointKeys {
//        static let url = "url"
//
//        static let heroes = "heroes"
//        static let heroe = "heroe"
//        static let events = "events"
    }
}

class Utils: NSObject {
        
//    // Endpoint.plist
//    public static func getEndpoints() -> [String: Any]? {
//        guard let path = Bundle.main.path(forResource: Constants.EndpointDictionary, ofType: Constants.EndpointExtension) else {
//            return nil
//        }
//        guard let dictionary = NSDictionary(contentsOfFile: path) else {
//            return nil
//        }
//        guard let result = dictionary as? [String: Any] else {
//            return nil
//        }
//        return result
//    }
    
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

import Foundation

struct HeroesResponse: Codable {
    let heroes: [Hero]
}

// MARK: - Hero
struct Hero: Codable {
    let response: String?
    let id: Int
    let name: String
    let powerstats: Powerstats
    let biography: Biography
    let appearance: Appearance
    let work: Work
    let connections: Connections
    let images: Image
}

// MARK: - Appearance
struct Appearance: Codable {
    let gender: String
    let race: String?
    let height, weight: [String]
    let eyeColor, hairColor: String
}

// MARK: - Biography
struct Biography: Codable {
    let fullName, alterEgos: String
    let aliases: [String]
    let placeOfBirth, firstAppearance, alignment: String
    let publisher: String?
}

// MARK: - Connections
struct Connections: Codable {
    let groupAffiliation, relatives: String
}

// MARK: - Image
struct Image: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "lg"
    }
}

// MARK: - Powerstats
struct Powerstats: Codable {
    let intelligence, strength, speed, durability: Int
    let power, combat: Int
    
    var strengthPercent: Float {
        return (Float(strength) ?? 0.0) / 100
    }
    
    var speedPercent: Float {
        return (Float(speed) ?? 0.0) / 100
    }
    
    var intelligencePercent: Float {
        return (Float(intelligence) ?? 0.0) / 100
    }
    
    var powerPercent: Float {
        return (Float(power) ?? 0.0) / 100
    }
    
    var combatPercent: Float {
        return (Float(combat) ?? 0.0) / 100
    }
    
    var durabilityPercent: Float {
        return (Float(durability) ?? 0.0) / 100
    }
}

// MARK: - Work
struct Work: Codable {
    let occupation, base: String
}

extension DataRequest {

    @discardableResult
    func prettyPrintedJsonResponse() -> Self {
        return responseJSON { (response) in
            switch response.result {
            case .success(let result):
                if let data = try? JSONSerialization.data(withJSONObject: result, options: .prettyPrinted),
                    let text = String(data: data, encoding: .utf8) {
                    print("📗 prettyPrinted JSON response: \n \(text)")
                }
            case .failure: break
            }
        }
    }
}
