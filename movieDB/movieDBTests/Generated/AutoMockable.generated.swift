// Generated using Sourcery 1.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import movieDB
@testable import movieDB











class HTTPSessionMock: HTTPSession {

    //MARK: - dataTask

    var dataTaskWithCompletionHandlerCallsCount = 0
    var dataTaskWithCompletionHandlerCalled: Bool {
        return dataTaskWithCompletionHandlerCallsCount > 0
    }
    var dataTaskWithCompletionHandlerReceivedArguments: (url: URL, completionHandler: (Data?, URLResponse?, Error?) -> Void)?
    var dataTaskWithCompletionHandlerReceivedInvocations: [(url: URL, completionHandler: (Data?, URLResponse?, Error?) -> Void)] = []
    var dataTaskWithCompletionHandlerReturnValue: URLSessionDataTask!
    var dataTaskWithCompletionHandlerClosure: ((URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask)?

    func dataTask(with url: URL,                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskWithCompletionHandlerCallsCount += 1
        dataTaskWithCompletionHandlerReceivedArguments = (url: url, completionHandler: completionHandler)
        dataTaskWithCompletionHandlerReceivedInvocations.append((url: url, completionHandler: completionHandler))
        return dataTaskWithCompletionHandlerClosure.map({ $0(url, completionHandler) }) ?? dataTaskWithCompletionHandlerReturnValue
    }

}
class MoviesRepositoryMock: MoviesRepository {

    //MARK: - movies

    var moviesCompletionCallsCount = 0
    var moviesCompletionCalled: Bool {
        return moviesCompletionCallsCount > 0
    }
    var moviesCompletionReceivedCompletion: (MoviesPageCompletion)?
    var moviesCompletionReceivedInvocations: [(MoviesPageCompletion)] = []
    var moviesCompletionClosure: ((@escaping MoviesPageCompletion) -> Void)?

    func movies(completion: @escaping MoviesPageCompletion) {
        moviesCompletionCallsCount += 1
        moviesCompletionReceivedCompletion = completion
        moviesCompletionReceivedInvocations.append(completion)
        moviesCompletionClosure?(completion)
    }

    //MARK: - movieDetails

    var movieDetailsWithCompletionCallsCount = 0
    var movieDetailsWithCompletionCalled: Bool {
        return movieDetailsWithCompletionCallsCount > 0
    }
    var movieDetailsWithCompletionReceivedArguments: (movieId: String, completion: DetailsCompletion)?
    var movieDetailsWithCompletionReceivedInvocations: [(movieId: String, completion: DetailsCompletion)] = []
    var movieDetailsWithCompletionClosure: ((String, @escaping DetailsCompletion) -> Void)?

    func movieDetails(with movieId: String, completion: @escaping DetailsCompletion) {
        movieDetailsWithCompletionCallsCount += 1
        movieDetailsWithCompletionReceivedArguments = (movieId: movieId, completion: completion)
        movieDetailsWithCompletionReceivedInvocations.append((movieId: movieId, completion: completion))
        movieDetailsWithCompletionClosure?(movieId, completion)
    }

}
class MoviesServiceMock: MoviesService {

    //MARK: - movies

    var moviesWithCompletionCallsCount = 0
    var moviesWithCompletionCalled: Bool {
        return moviesWithCompletionCallsCount > 0
    }
    var moviesWithCompletionReceivedArguments: (page: Int, completion: MoviesListCompletion)?
    var moviesWithCompletionReceivedInvocations: [(page: Int, completion: MoviesListCompletion)] = []
    var moviesWithCompletionClosure: ((Int, @escaping MoviesListCompletion) -> Void)?

    func movies(with page: Int, completion: @escaping MoviesListCompletion) {
        moviesWithCompletionCallsCount += 1
        moviesWithCompletionReceivedArguments = (page: page, completion: completion)
        moviesWithCompletionReceivedInvocations.append((page: page, completion: completion))
        moviesWithCompletionClosure?(page, completion)
    }

    //MARK: - movieDetails

    var movieDetailsWithCompletionCallsCount = 0
    var movieDetailsWithCompletionCalled: Bool {
        return movieDetailsWithCompletionCallsCount > 0
    }
    var movieDetailsWithCompletionReceivedArguments: (movieId: String, completion: MovieDetailsCompletion)?
    var movieDetailsWithCompletionReceivedInvocations: [(movieId: String, completion: MovieDetailsCompletion)] = []
    var movieDetailsWithCompletionClosure: ((String, @escaping MovieDetailsCompletion) -> Void)?

    func movieDetails(with movieId: String, completion: @escaping MovieDetailsCompletion) {
        movieDetailsWithCompletionCallsCount += 1
        movieDetailsWithCompletionReceivedArguments = (movieId: movieId, completion: completion)
        movieDetailsWithCompletionReceivedInvocations.append((movieId: movieId, completion: completion))
        movieDetailsWithCompletionClosure?(movieId, completion)
    }

}
