import Foundation

// MARK: - Hero
struct Hero: Codable {
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
        return (Float(strength) ) / 100
    }
    
    var speedPercent: Float {
        return (Float(speed) ) / 100
    }
    
    var intelligencePercent: Float {
        return (Float(intelligence) ) / 100
    }
    
    var powerPercent: Float {
        return (Float(power) ) / 100
    }
    
    var combatPercent: Float {
        return (Float(combat) ) / 100
    }
    
    var durabilityPercent: Float {
        return (Float(durability) ) / 100
    }
}

// MARK: - Work
struct Work: Codable {
    let occupation, base: String
}
