//
//  ToDoModel.swift
//  TodoListApp
//
//  Created by Дима Тарасов on 24.07.2025.
//

import Foundation

struct ToDoModel: Codable {
    
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

struct Todos: Codable {
    
    let todos: [ToDoModel]
}
