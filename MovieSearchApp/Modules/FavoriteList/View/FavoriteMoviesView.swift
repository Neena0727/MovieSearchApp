

import SwiftUI

struct FavoriteMoviesView: View {
    @State private var favoriteMovies: [FavoriteMovieEntity] = []
    private let coreDataManager = CoreDataManager.shared

    var body: some View {
        VStack {
            if favoriteMovies.isEmpty {
                Text("No favorite movies yet.")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(favoriteMovies, id: \.id) { movie in
                    HStack {
                        if let posterPath = movie.posterPath,
                           let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 75)
                                    .cornerRadius(5)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 75)
                                    .background(Color.gray.opacity(0.2))
                            }
                        } else {
                            Image(systemName: "film")
                                .resizable()
                                .frame(width: 50, height: 75)
                                .cornerRadius(5)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text(movie.title ?? "Unknown Title")
                                .font(.headline)
                            Text(movie.releaseDate ?? "Unknown Release Date")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 10)
                    }
                    .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            fetchFavoriteMovies()
        }
        .navigationTitle("Favorite Movies")
    }

    private func fetchFavoriteMovies() {
        favoriteMovies = coreDataManager.fetchFavoriteMovies()
    }
}

struct FavoriteMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesView()
    }
}
