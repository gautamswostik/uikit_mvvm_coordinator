//
//  TrendingModel.swift
//  TMDB_UiKIT_MVVM
//
//  Created by swostik gautam on 26/01/2023.
//

import Foundation

struct TrendingData: Codable  {
    var page: Int?
    var results: [TrendingResult]?
    var total_pages, total_results: Int?
}

struct TrendingResult: Codable  {
    var adult: Bool?
    var backdrop_path: String?
    var id: Int?
    var title: String?
    var original_language: String?
    var original_title: String?
    var overview, poster_path: String?
    var media_type: String?
    var genre_ids: [Int]?
    var popularity: Double?
    var release_date: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
    var name, original_name, first_air_date: String?
    var origin_country: [String]?
}
