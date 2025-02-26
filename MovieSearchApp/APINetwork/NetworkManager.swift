//
//  NetworkManager.swift
//  MovieTask
//
//  Created by Mac on 25/02/25.
//

import Alamofire
import Foundation
import Network

class NetworkManager {
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "f45475d648270c30cb8dc982a6151db8"
    
    private var monitor: NWPathMonitor
    private var isConnected: Bool

    init() {
        self.monitor = NWPathMonitor()
        self.isConnected = false

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
    }

    func isInternetAvailable() -> Bool {
        return isConnected
    }


    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard isInternetAvailable() else {
            completion(.failure(NetworkError.noInternet))
            return
        }

        let url = "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(query)"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: MovieSearchResponse.self) { response in
                switch response.result {
                case .success(let movieSearchResponse):
                    let movies = movieSearchResponse.results.map { movieSearchResult -> Movie in
                        return Movie(
                            id: movieSearchResult.id,
                            title: movieSearchResult.title,
                            releaseDate: movieSearchResult.releaseDate,
                            posterPath: movieSearchResult.posterPath,
                            voteAverage: movieSearchResult.voteAverage,
                            overview: movieSearchResult.overview
                        )
                    }
                    completion(.success(movies))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func getMovieDetails(movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        let url = "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)"
        print("url",url)
        AF.request(url)
            .validate()
            .responseDecodable(of: Movie.self) { response in
                switch response.result {
                case .success(let movieDetail):
                    completion(.success(movieDetail))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

enum NetworkError: Error {
    case noInternet
    case otherError
}
