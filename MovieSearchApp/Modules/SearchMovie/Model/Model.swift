//
//  Model.swift
//  MovieTask
//
//  Created by Mac on 25/02/25.
//

import Foundation

struct MovieSearchResponse: Decodable {
    let results: [Movie]
}

struct Movie: Identifiable, Codable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let posterPath: String?
    let voteAverage: Double?
    let overview: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case overview = "overview"
    }
    
    var fullPosterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}
