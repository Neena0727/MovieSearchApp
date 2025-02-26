//
//  CoreDataManager.swift
//  MovieSearchApp
//
//  Created by Mac on 25/02/25.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private(set) var context: NSManagedObjectContext
    
    private init() {
        let persistenceController = PersistenceController.shared
        self.context = persistenceController.container.viewContext
    }

    // MARK: - Save favorite movie
    func saveFavoriteMovie(movie: Movie) {
        let favoriteMovie = FavoriteMovieEntity(context: context)
        favoriteMovie.id = Int64(movie.id ?? 0)
        favoriteMovie.title = movie.title
        favoriteMovie.releaseDate = movie.releaseDate
        favoriteMovie.posterPath = movie.posterPath
        favoriteMovie.voteAverage = movie.voteAverage ?? 0.0
        favoriteMovie.overview = movie.overview
        
        do {
            try context.save()
        } catch {
            print("Failed to save movie: \(error)")
        }
    }
    
    // MARK: - Fetch favorite movies
    func fetchFavoriteMovies() -> [FavoriteMovieEntity] {
        let fetchRequest: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
        do {
            let favoriteMovies = try context.fetch(fetchRequest)
            return favoriteMovies
        } catch {
            print("Failed to fetch favorite movies: \(error)")
            return []
        }
    }
    
    // MARK: - Delete favorite movie
    func deleteFavoriteMovie(movie: FavoriteMovieEntity) {
        context.delete(movie)
        do {
            try context.save()
        } catch {
            print("Failed to delete movie: \(error)")
        }
    }
}

