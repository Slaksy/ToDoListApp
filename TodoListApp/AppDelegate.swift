//
//  AppDelegate.swift
//  TodoListApp
//
//  Created by Дима Тарасов on 22.07.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Properties
    var window: UIWindow?
    
    // MARK: - Internal Methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        setupWindow() // TODO: место где нужно что-то доделать
        
        return true
    }

    // MARK: - Private Methods
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = ViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

