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
}

extension DataRequest {

    @discardableResult
    func prettyPrintedJsonResponse() -> Self {
        return responseJSON { (response) in
            switch response.result {
            case .success(let result):
                if let data = try? JSONSerialization.data(withJSONObject: result, options: .prettyPrinted),
                    let text = String(data: data, encoding: .utf8) {
                    print("✅ JSON response: \n \(text)")
                }
            case .failure: break
            }
        }
    }
}
