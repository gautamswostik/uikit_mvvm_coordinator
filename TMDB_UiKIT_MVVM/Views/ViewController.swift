//
//  ViewController.swift
//  TMDB_UiKIT_MVVM
//
//  Created by swostik gautam on 26/01/2023.
//

import UIKit
import RxSwift

class TMDBViewController: UIViewController {
    var trendingViewModel = TMDBViewModel()
    weak var mainCoordinator: MainCoordinator?
    
    var simpleViewModel :SimpleViewModel = .init(nonObservableButtonName: "Hello this is buton" )
    var trendingData: TrendingData = .init() {
        didSet {
            button.setTitle(trendingData.results?.first?.title ?? "NO TITLE", for: .normal)
            label.text =  trendingData.results?.first?.title
            
        }
    }
    
    var disposeBag:DisposeBag = DisposeBag()
    
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.title =  simpleViewModel.nonObservableButtonName
        button.addTarget(self, action: #selector(navigateToSecondScreen), for: .touchUpInside)
        return button
    }()
    
    lazy var label: UILabel = {
        let button = UILabel()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        view.addSubview(button)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 10),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: button.topAnchor),
            
        ])
        
        trendingViewModel
            .isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                if(data){
                    print("Loading")
                    return
                }
                print("Loaded")
            }).disposed(by: disposeBag)
        
        
        trendingViewModel
            .tmdbTrendingData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                self.trendingData = data
            }).disposed(by: disposeBag)
        trendingViewModel.getTrendingData()
    }
    
    @objc func bindButtonName() {
        
    }
    
    @objc func navigateToSecondScreen(){
        
        view.backgroundColor = simpleViewModel.returnColor()
        simpleViewModel.returnnonObservableButtonName(name: "OLA")
        label.text =  simpleViewModel.nonObservableButtonName
        button.setTitle( simpleViewModel.nonObservableButtonName, for: .normal)
        self.mainCoordinator?.gotoSecondScreen()
    }
}

