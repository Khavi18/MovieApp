//
//  Movies.swift
//  MovieApp
//
//  Created by khavishini suresh on 30/11/2022.
//

import Foundation

struct Movies: Codable {
    var page: Int
    var results: [Results]
    var totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
    
    init() {
        self.page = 1
        self.totalPages = 10
        self.results = []
    }
}

struct Results: Codable {
    var title: String
    var voteAverage: Double
    var poster: String?
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case title, id
        case voteAverage = "vote_average"
        case poster = "poster_path"
    }
    
    init() {
        self.title = " "
        self.voteAverage = 0.00
        self.poster = nil
        self.id = 0
    }
}

struct MovieDetail: Codable {
    var backdrop: String?
    var title: String
    var overview: String?
    var runtime: Int?
    var voteAverage: Double
    var voteCount: Int
    var popularity: Double
    
    enum CodingKeys: String, CodingKey {
        case title, overview, runtime, popularity
        case backdrop = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init() {
        self.title = "Movie Title"
        self.voteAverage = 0.00
        self.voteCount = 0
        self.popularity = 0.00
    }
}
