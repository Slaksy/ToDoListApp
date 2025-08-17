//
//  ViewController.swift
//  TodoListApp
//
//  Created by Дима Тарасов on 22.07.2025.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoService.getTodos { result in
            switch result {
            case .success(let todos):
                print(todos)
            case .failure(let error):
                print(error)
            }
        }
        
        view.backgroundColor = .systemGreen
    }
    
    let todoService: TodoService = TodoService()
    
}

