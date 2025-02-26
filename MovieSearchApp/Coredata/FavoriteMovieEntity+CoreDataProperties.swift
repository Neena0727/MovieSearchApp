//
//  FavoriteMovieEntity+CoreDataProperties.swift
//  MovieSearchApp
//
//  Created by Mac on 25/02/25.
//
//

import Foundation
import CoreData


extension FavoriteMovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovieEntity> {
        return NSFetchRequest<FavoriteMovieEntity>(entityName: "FavoriteMovieEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var overview: String?

}

extension FavoriteMovieEntity : Identifiable {

}
