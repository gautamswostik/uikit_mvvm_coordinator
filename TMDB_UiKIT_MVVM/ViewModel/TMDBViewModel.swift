//
//  TMDBViewModel.swift
//  TMDB_UiKIT_MVVM
//
//  Created by swostik gautam on 27/01/2023.
//

import Foundation
import RxSwift

class TMDBViewModel {
    private var tmdbApiService = TMDBApiService()
    
    var tmdbTrendingData:  PublishSubject<TrendingData>  = .init()
    var isLoading: PublishSubject<Bool> = .init()
    var error: PublishSubject<Error> = .init()
    
    func getTrendingData() {
        isLoading.onNext(true)
        tmdbApiService.fetchTrendingData { trendingData in
            self.isLoading.onNext(false)
            switch trendingData {
            case .success(let trendingData):
                self.tmdbTrendingData.onNext(trendingData)
            case .failure(let error):
                self.error.onNext(error)
            }
        }
    }
    
}
