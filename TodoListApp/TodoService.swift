import Foundation

protocol ITodoService {
    
    func getTodos(completion: @escaping (Result<Todos, NetworkError>) -> Void)
}

final class TodoService {
    
    // MARK: - Properties
    
    static let shared: ITodoService = TodoService()
    
    private let networkService: INetworkService
    
    // MARK: - Init
    
    private init(){
        self.networkService = NetworkService.shared
    }
}

// MARK: - ITodoService

extension TodoService: ITodoService {
    
    func getTodos(completion: @escaping (Result<Todos, NetworkError>) -> Void) {
        
        networkService.request(TodoEndpoint.todos, completion: completion)
    }
}
