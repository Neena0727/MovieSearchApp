

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @State private var movieDetail: Movie?
    @State private var isLoading = true
    @State private var isFavorite = false
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                    .padding()
            } else if let movieDetail = movieDetail {
                
                Text(movieDetail.title ?? "No Movie available")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding([.top, .horizontal])
                
                Text(movieDetail.overview ?? "No description available.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding([.horizontal, .bottom])

                AsyncImage(url: movieDetail.fullPosterURL) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 300)
                        .cornerRadius(10)
                } placeholder: {
                    Image(systemName: "film")
                        .resizable()
                        .frame(width: 200, height: 300)
                        .cornerRadius(10)
                }

                HStack {
                    Text("Rating:")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(String(format: "%.1f", movieDetail.voteAverage ?? 0.0))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                }
                .padding([.horizontal, .bottom])

                Button(action: toggleFavorite) {
                    Text(isFavorite ? "Remove from Favorites" : "Add to Favorites")
                        .fontWeight(.medium)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isFavorite ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
            }
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .padding()
        .onAppear {
            fetchMovieDetails()
        }
    }

    func fetchMovieDetails() {
        networkManager.getMovieDetails(movieId: movieId) { result in
            switch result {
            case .success(let movieDetail):
                self.movieDetail = movieDetail
                checkIfFavorite(movieDetail: movieDetail)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
    
    func checkIfFavorite(movieDetail: Movie) {
        let favorites = coreDataManager.fetchFavoriteMovies()
        isFavorite = favorites.contains { favorite in
            favorite.id == movieDetail.id ?? 0
        }
    }

    func toggleFavorite() {
        guard let movieDetail = movieDetail else { return }
        
        if isFavorite {
            if let favoriteMovie = coreDataManager.fetchFavoriteMovies().first(where: { $0.id == movieDetail.id ?? 0 }) {
                coreDataManager.deleteFavoriteMovie(movie: favoriteMovie)
            }
        } else {
            coreDataManager.saveFavoriteMovie(movie: movieDetail)
        }
        
        isFavorite.toggle()
    }
}
