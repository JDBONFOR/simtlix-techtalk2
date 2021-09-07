import Foundation

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

