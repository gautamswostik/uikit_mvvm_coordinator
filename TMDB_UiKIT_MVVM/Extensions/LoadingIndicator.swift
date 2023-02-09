//
//  LoadingIndicator.swift
//  TMDB_UiKIT_MVVM
//
//  Created by swostik gautam on 28/01/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Loading", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 5, y: 10, width: 30, height: 30))
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        alert.view.addSubview(indicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func stopLoader(loader: UIAlertController){
        DispatchQueue.main.async {
            loader.dismiss(animated: true , completion: nil)
        }
    }
}
