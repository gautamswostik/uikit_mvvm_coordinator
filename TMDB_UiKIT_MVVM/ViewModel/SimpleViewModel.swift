//
//  SimpleViewModel.swift
//  TMDB_UiKIT_MVVM
//
//  Created by swostik gautam on 28/01/2023.
//

import Foundation
import Material

class SimpleViewModel {
    var nonObservableButtonName: String = String()
    init( nonObservableButtonName: String){
        self.nonObservableButtonName = nonObservableButtonName
    }
    
    func returnButtonName() -> String {
        return nonObservableButtonName
    }
    
    func returnnonObservableButtonName(name: String) -> String {
        self.nonObservableButtonName = name
        return nonObservableButtonName;
    }
    
    func returnColor() -> UIColor {
        return .darkGray
    }
}
