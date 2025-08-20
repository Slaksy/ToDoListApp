//
//  TodoService.swift
//  TodoListApp
//
//  Created by Дима Тарасов on 20.08.2025.
//

import Foundation

protocol ITodoService {
    
    func getTodos(completion: @escaping (Result<Todos, NetworkError>) -> Void)
}

final class TodoService {
    
    //MARK: Properties
    
    static let shared: ITodoService = TodoService()
    
    //MARK: Init
    
    private init(){
        self.networkService = NetworkService.shared
    }
    
    private let networkService: INetworkService
    
}

// MARK: ITodoService

extension TodoService: ITodoService {
    
    func getTodos(completion: @escaping (Result<Todos, NetworkError>) -> Void) {
        networkService.request(DummyJsonEndpoint.todos, completion: completion)
    }

}
