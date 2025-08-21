import UIKit

final class TodoListVC: UIViewController {
    
    // MARK: - Properties
    
    private let todoService: ITodoService
    
    // MARK: - Init
    
    init() {
        self.todoService = TodoService.shared
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        
        getTodos()
    }
    
    //MARK: - getTodos
    
    private func getTodos() {
        todoService.getTodos { result in
            switch result {
            case .success(let todos):
                print(todos)
            case .failure(let error):
                print(error)
            }
        }
    }
}
