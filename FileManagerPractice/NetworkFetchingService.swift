import Foundation

enum NetworkError: Error {
    case invalidStatusCode(Int)
    case missingData
    case missingResponse
    case unknown
    case urlSessionError(Error)
}

class NetworkFetchingService {
    public static let shared = NetworkFetchingService()
    
    private let urlSession: URLSession
    
    private init() {
        urlSession = URLSession(configuration: .default)
    }
    
    func performDataTask(with request: URLRequest, onCompletion: @escaping (Result<Data, NetworkError>) -> Void) {
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(.urlSessionError(error)))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                onCompletion(.failure(.missingData))
                return
            }
            guard let data = data else {
                onCompletion(.failure(.missingData))
                return
            }
            switch response.statusCode {
            case 200...299: break
            default:
                onCompletion(.failure(.invalidStatusCode(response.statusCode)))
                return
            }
            onCompletion(.success(data))
        }.resume()
    }
}
