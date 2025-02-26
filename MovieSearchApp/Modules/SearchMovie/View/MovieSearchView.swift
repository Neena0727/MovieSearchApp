import SwiftUI

struct MovieSearchView: View {
    @State private var searchText = ""
    @State private var movies: [Movie] = []
    @State private var isLoading = false
    private let networkManager = NetworkManager()
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Movie", text: $searchText, onCommit: {
                    searchMovies(query: searchText)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if isLoading {
                    ProgressView()
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                List(movies) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: movie.id ?? 0)) {
                        HStack(spacing: 10) {
                            if let posterURL = movie.fullPosterURL {
                                AsyncImage(url: posterURL) { image in
                                    image.resizable()
                                        .frame(width: 50, height: 75)
                                } placeholder: {
                                    ProgressView()
                                }
                            } else {
                                Image(systemName: "film").resizable()
                                    .frame(width: 50, height: 75)
                            }

                            VStack(alignment: .leading, spacing: 5) {
                                Text(movie.title ?? "")
                                    .font(.headline)
                                Text(movie.releaseDate ?? "")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())

                NavigationLink(destination: FavoriteMoviesView()) {
                    Text("View Favorite Movies")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)
            }
            .navigationTitle("Movie Search")
            .padding()
            .onAppear {
                if !networkManager.isInternetAvailable() {
                    errorMessage = "No internet connection available."
                } else {
                    errorMessage = nil
                }
            }
        }
    }

    func searchMovies(query: String) {
        guard !query.isEmpty else {
            errorMessage = "Please enter a movie title to search."
            return
        }

        isLoading = true
        errorMessage = nil

        networkManager.searchMovies(query: query) { result in
            switch result {
            case .success(let movieResults):
                self.movies = movieResults
            case .failure(let error):
                if let networkError = error as? NetworkError, networkError == .noInternet {
                    errorMessage = "No internet connection available."
                } else {
                    errorMessage = "An unexpected error occurred."
                }
            }
            isLoading = false
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
