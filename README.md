# MovieSearchApp

The MovieSearchApp is an iOS application built using SwiftUI, Alamofire, and Core Data to allow users to search for movies, view movie details, and manage a list of favorite movies. This app interacts with The Movie Database (TMDb) API to search for movies and fetch movie details. Users can add movies to their favorites list and view them later. The app also leverages Core Data for local storage of favorite movies.

Features
Movie Search:

Users can search for movies by title using the search bar.
The search results display a list of movies with titles, release dates, and posters.
The user can select a movie to view detailed information.
Movie Details:

Movie details are fetched from TMDb, including the title, release date, overview, rating, and poster image.
Users can add or remove movies from their favorites list.
Favorites Management:

Users can view a list of their favorite movies stored locally in Core Data.
Users can add or remove movies from the favorites list.
The favorite movies list is saved persistently using Core Data.
Offline Support:

The app uses Network Framework to monitor the network connection and provides appropriate feedback to the user if there's no internet connection.
Technologies Used
SwiftUI: The user interface is built using SwiftUI, Apple's declarative framework for building user interfaces across all Apple platforms.
Alamofire: This library is used for making network requests to the TMDb API for movie search and movie details.
Core Data: Used for persisting and managing the favorite movies locally.
Network Framework: For monitoring the network connection status to handle online/offline states.
TMDb API: The Movie Database API is used for fetching movie data.
Core Components
1. NetworkManager:
The NetworkManager class is responsible for making network requests to the TMDb API. It checks for internet availability and handles movie search and fetching movie details.

searchMovies(query:completion:): Searches for movies based on the query string.
getMovieDetails(movieId:completion:): Fetches detailed information about a movie using its ID.
isInternetAvailable(): Checks if the device is connected to the internet using NetworkMonitor.
2. CoreDataManager:
The CoreDataManager class handles saving, fetching, and deleting movies from Core Data. It interacts with the FavoriteMovieEntity managed object.

saveFavoriteMovie(movie:): Saves a movie to Core Data.
fetchFavoriteMovies(): Fetches all favorite movies from Core Data.
deleteFavoriteMovie(movie:): Deletes a favorite movie from Core Data.
3. Movie Models:
Movie: A model representing a movie, including properties like id, title, releaseDate, posterPath, voteAverage, and overview.
MovieSearchResponse: A model used to decode the search response from the TMDb API.
The Movie model also provides a computed property fullPosterURL to construct the full URL for movie posters.

4. UI Components:
MovieSearchView: A view that allows users to search for movies and displays the results.
MovieDetailView: A view that displays detailed information about a selected movie and provides the option to add or remove the movie from favorites.
FavoriteMoviesView: A view that shows the list of favorite movies stored in Core Data.
User Interface
1. Movie Search View:
A search bar at the top allows users to input a movie title.
A list of movies matching the search query is displayed with titles, release dates, and poster images.
Tapping on a movie navigates to the movie detail view.
2. Movie Detail View:
Shows the full details of the selected movie, including title, overview, rating, and poster.
Users can toggle the movie between their favorites list using a button that changes based on whether the movie is already a favorite.
3. Favorite Movies View:
Displays a list of favorite movies stored in Core Data.
Shows each movie’s title, release date, and poster image.
If the list is empty, a message is displayed to inform the user.
Core Data Structure
The Core Data model consists of the following entity:

FavoriteMovieEntity: An entity representing a favorite movie with the following attributes:
id: The unique identifier for the movie.
title: The movie's title.
releaseDate: The release date of the movie.
posterPath: The path to the movie's poster image.
voteAverage: The average vote score for the movie.
overview: A brief overview of the movie.
Setup and Installation
Requirements:
Xcode 12 or later.
Swift 5.0 or later.
Alamofire library.
Core Data.
Steps to Run the Project:
Clone this repository to your local machine.

bash
Copy
git clone https://github.com/your-username/MovieTask.git
Open the project in Xcode.

bash
Copy
open MovieTask.xcodeproj
Run the project on a simulator or a physical device.

Make sure you have internet access since the app fetches movie data from TMDb.
To add your own TMDb API key, replace the existing API key in the NetworkManager.swift file with your own key:

swift
Copy
private let apiKey = "YOUR_TMDB_API_KEY"
