import Foundation

typealias MoviesListCompletion = (Result<MoviesDTO, MoviesServiceError>) -> Void
typealias MovieDetailsCompletion = (Result<MovieDetailsDTO, MoviesServiceError>) -> Void

enum MoviesServiceError: Error {
    case unknown
    case badURL
    case httpError
    case apiError(Error)
}

// sourcery: AutoMockable
protocol MoviesService {
    func movies(with page: Int, completion: @escaping MoviesListCompletion)
    func movieDetails(with movieId: String, completion: @escaping MovieDetailsCompletion)
}

class MoviesServiceImpl: MoviesService {
    private let session: HTTPSession
    private let apiKey: String

    init(apiKey: String = "e5a7a90ede668398505588b032cae4c9", session: HTTPSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.apiKey = apiKey
        self.session = session
    }

    func movies(with page: Int, completion: @escaping MoviesListCompletion) {
        let strURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&page=\(page)"
        guard let url = URL(string: strURL) else {
            completion(.failure(.badURL))
            return
        }

        let task = session.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                completion(.failure(.apiError(error)))
                return
            }

            guard let response = urlResponse as? HTTPURLResponse,
                  (200 ... 299).contains(response.statusCode) else {
                completion(.failure(.httpError))
                return
            }

            guard let data = data,
                let responseModel = try? JSONDecoder().decode(MoviesDTO.self, from: data) else {
                completion(.failure(MoviesServiceError.unknown))
                    return
                }
            completion(.success(responseModel))
        }

        task.resume()
    }

    func movieDetails(with movieId: String, completion: @escaping MovieDetailsCompletion) {
        let strURL = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)"
        guard let url = URL(string: strURL) else {
            completion(.failure(.badURL))
            return
        }

        let task = session.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                completion(.failure(.apiError(error)))
                return
            }

            guard let response = urlResponse as? HTTPURLResponse,
                  (200 ... 299).contains(response.statusCode) else {
                completion(.failure(.httpError))
                return
            }

            guard let data = data,
                let responseModel = try? JSONDecoder().decode(MovieDetailsDTO.self, from: data) else {
                completion(.failure(MoviesServiceError.unknown))
                    return
                }
            completion(.success(responseModel))
        }

        task.resume()
    }
}

extension URLSession: HTTPSession {}
