import Foundation

struct HeroListModel: Codable {
    let id: Int
    let name: String
    let images: HeroListImage
    
    enum CodingKeys: String, CodingKey {
        case id, name, images
    }
}

struct HeroListImage: Codable {
    let sm: String
}
