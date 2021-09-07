
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
    
//    func loadHeroesJson() -> HeroesResponse? {
//        if let json = self.readLocalFile(forName: "heroes"),
//           let data = self.parse(jsonData: json) {
//            return data
//        }
//        return nil
//    }
//
//    private func readLocalFile(forName name: String) -> Data? {
//        do {
//            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
//               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
//                return jsonData
//            }
//        } catch {
//            print(error)
//        }
//
//        return nil
//    }
//
//    private func parse(jsonData: Data) -> HeroesResponse? {
//        do {
//            let decodedData = try JSONDecoder().decode(HeroesResponse.self,
//                                                       from: jsonData)
//            print("===================================")
//            return decodedData
//        } catch {
//            print("decode error")
//            return nil
//        }
//    }
}


import Foundation

struct HeroesResponse: Codable {
    let heroes: [Hero]
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
