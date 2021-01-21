import Foundation

typealias MoviesListCompletion = (Result<MoviesDTO, MoviesServiceError>) -> Void

enum MoviesServiceError: Error {
    case unknown
    case badURL
    case httpError
    case apiError(Error)
}
protocol MoviesService {
    func movies(with page: Int, completion: @escaping MoviesListCompletion)
}

class MoviesServiceImpl: MoviesService {
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let apiKey: String

    init(key: String = "e5a7a90ede668398505588b032cae4c9") {
        apiKey = key
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
}
