import Foundation

protocol INetworkService {
    
    func request<T: Decodable>(_ endpoint: IEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkService {
    
    //MARK: Properties
    
    static let shared: INetworkService = NetworkService()
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    //MARK: Init
    
    private init(){
        self.session = .shared
        self.decoder = JSONDecoder()
    }
}

// MARK: INetworkService

extension NetworkService: INetworkService {
    
    func request<T: Decodable>(_ endpoint: IEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
            
            guard let url = endpoint.url else {
                completion(.failure(.invalidURL))
                return
            }
            
            var request =  URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue
            request.allHTTPHeaderFields = endpoint.headers
            
            if let body = endpoint.body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            let task = session.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    completion(.failure(.networkError(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.httpError(statusCode: httpResponse.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            
            task.resume()
        }
}

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case httpError(statusCode: Int)
    case noData
    case decodingError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invald URL"
        case .networkError(let error): return "Network error: \(error.localizedDescription)"
        case .invalidResponse: return "Invalid response from server"
        case .httpError(let statusCode): return "HTTP error with status code: \(statusCode)"
        case .noData: return "No data recived"
        case .decodingError(let error): return "Decoding error: \(error.localizedDescription)"
        }
    }
}

enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol IEndpoint {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: [String: Any]? { get }
}

    extension IEndpoint {
    var url: URL? {
        return URL (string: baseURL + path)
    }
}

enum DummyJsonEndpoint: IEndpoint {
    
    case todos
    
    var baseURL: String {
        return "https://dummyjson.com"
    }
    
    var path: String {
        return "/todos"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var body: [String : Any]? {
        return nil
    }
    
}

