//
//  AppCoordinator.swift
//  TMDB_UiKIT_MVVM
//
//  Created by swostik gautam on 27/01/2023.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get}
    var navigationController: UINavigationController {get}
    func start()
}


class MainCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController = UINavigationController()
    
    func start() {
        let initialViewController = TMDBViewController()
        initialViewController.mainCoordinator = self
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(initialViewController, animated: false)
    }
    
    
    func gotoSecondScreen() {
        let nextScreen = SecondViewController()
        nextScreen.mainCoordinator = self
        navigationController.pushViewController(nextScreen, animated: true)
    }
    
    func gotoThirdScreen() {
        let nextScreen = ThirdViewController()
        navigationController.pushViewController(nextScreen, animated: true)
    }
}
