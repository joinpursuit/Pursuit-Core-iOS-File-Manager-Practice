import Foundation

class CharacterFetchingService {
    public static let shared = CharacterFetchingService()
    
    private let rickAndMortyEndpoint = URL(string: "https://rickandmortyapi.com/api/character/")!
    
    private init() {}
    
    func getCharacters(onCompletion: @escaping (Result<[RickAndMortyCharacter], Error>) -> Void) {
        let request = URLRequest(url: rickAndMortyEndpoint)
        NetworkFetchingService.shared.performDataTask(with: request) { result in
            switch result {
            case let .success(data):
                onCompletion(.success(RickAndMortyCharacter.characters(from: data)))
            case let .failure(error):
                onCompletion(.failure(error))
            }
        }
    }
}
