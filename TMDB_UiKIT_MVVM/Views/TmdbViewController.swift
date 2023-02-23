//
//  ViewController.swift
//  TMDB_UiKIT_MVVM
//
//  Created by swostik gautam on 26/01/2023.
//

import UIKit
import RxSwift
import SDWebImage

class TMDBViewController: UIViewController {
    var trendingViewModel = TMDBViewModel()
    weak var mainCoordinator: MainCoordinator?
    
    var simpleViewModel :SimpleViewModel = .init(nonObservableButtonName: "Hello this is buton" )
    var trendingData: TrendingData = .init() {
        didSet {
            button.setTitle(trendingData.results?.first?.title ?? "NO TITLE", for: .normal)
            label.text =  trendingData.results?.first?.title
            if scrollView.subviews.count == 2 {
                configureScrollView(results:trendingData.results ?? [])
            }
        }
    }
    
    var disposeBag:DisposeBag = DisposeBag()
    
    let scrollView: UIScrollView  = {
        let scrollView =  UIScrollView()
        return scrollView
    }()
    
    
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.hidesWhenStopped = true
        return indicator
    } ()
    
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
        view.addSubview(indicator)
        view.addSubview(scrollView)
        indicator.center = view.center
        
        
        
        NSLayoutConstraint.activate([])
        
        trendingViewModel
            .isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                if(data){
                    self.indicator.startAnimating()
                    print("Loading")
                    return
                }
                self.indicator.stopAnimating()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height*0.70)
    }
    
    private func configureScrollView(results: [TrendingResult]) {
        let resultsCount: Int = results.count
        scrollView.contentSize = CGSize(width: view.frame.size.width*CGFloat(resultsCount), height: scrollView.frame.size.height*0.70)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        for i in 0..<resultsCount {
            let zStack = UIStackView()
            zStack.frame = CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height*0.70)
            zStack.layer.cornerRadius = 80
            
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let imageURL = URL(string:"https://image.tmdb.org/t/p/original\(results[i].poster_path ?? "")")
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
            imageView.blurImage()
            zStack.addSubview(imageView)
            
            let subImageView = UIImageView()
            subImageView.translatesAutoresizingMaskIntoConstraints = false
            subImageView.contentMode = .scaleAspectFit
            subImageView.clipsToBounds = true
            subImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
            subImageView.layer.cornerRadius = 100
            zStack.addSubview(subImageView)
            
            scrollView.addSubview(zStack)
            scrollView.bringSubviewToFront(zStack)
 
            scrollView.layer.cornerRadius = 20
            scrollView.layer.maskedCorners = [.layerMinXMaxYCorner , .layerMaxXMaxYCorner]
            
            NSLayoutConstraint.activate([
                zStack.topAnchor.constraint(equalTo: view.topAnchor),
                zStack.topAnchor.constraint(equalTo: view.bottomAnchor),
                zStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                zStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                imageView.heightAnchor.constraint(equalTo: zStack.heightAnchor),
                imageView.widthAnchor.constraint(equalTo: zStack.widthAnchor),
                
                subImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 50),
                subImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -50),
                subImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                subImageView.topAnchor.constraint(equalTo: imageView.topAnchor),
                subImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
            ])
        }
    }
    
    @objc func navigateToSecondScreen(){
        self.mainCoordinator?.gotoSecondScreen()
    }
}

extension UIImageView{
    func blurImage()
    {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

