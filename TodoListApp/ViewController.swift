//
//  TodoListVC.swift
//  TodoListApp
//
//  Created by Дима Тарасов on 22.07.2025.
//

import UIKit

final class TodoListVC: UIViewController {
    
    //MARK: Properties
    
    private let todoService: ITodoService
    
    //MARK: Init
    
      init() {
         self.todoService = TodoService.shared
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
}
