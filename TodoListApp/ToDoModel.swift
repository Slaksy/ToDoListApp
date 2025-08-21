import Foundation

struct TodoModel: Codable {
    
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

struct Todos: Codable {
    
    let todos: [TodoModel]
    let total: Int
}
