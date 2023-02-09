//
//  SecondViewController.swift
//  TMDB_UiKIT_MVVM
//
//  Created by swostik gautam on 28/01/2023.
//

import UIKit

class SecondViewController: UIViewController {
    weak var mainCoordinator: MainCoordinator?
    
     var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.title =  "Goto third"
        button.addTarget(self, action: #selector(navigateToThirdScreen), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = "This is Second Screen"
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 10),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func navigateToThirdScreen(){
        self.mainCoordinator?.gotoThirdScreen()
    }
}
