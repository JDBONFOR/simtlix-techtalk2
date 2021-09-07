import Foundation

struct HeroeListModel: Codable {
    let id: Int
    let name: String
    let images: HeroeListImage
    
    enum CodingKeys: String, CodingKey {
        case id, name, images
    }
}

struct HeroeListImage: Codable {
    let lg: String
}
