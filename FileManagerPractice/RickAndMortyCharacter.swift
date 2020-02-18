import Foundation

struct RickAndMortyAPIResponse: Codable {
    let info: RickAndMortyAPIResponseInfo
    let results: [RickAndMortyCharacter]
}

struct RickAndMortyAPIResponseInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct RickAndMortyCharacter: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let imageURL: String
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, imageURL = "image"
    }
    static func characters(from jsonData: Data) -> [RickAndMortyCharacter] {
        do {
            let characters = try JSONDecoder().decode(RickAndMortyAPIResponse.self, from: jsonData).results
            return characters
        } catch {
            return []
        }
    }
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}
