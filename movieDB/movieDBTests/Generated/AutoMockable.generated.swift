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

@testable import movieDB

class ConnectionManagerMock: ConnectionManager {
    var connected: Bool {
        get { return underlyingConnected }
        set(value) { underlyingConnected = value }
    }
    var underlyingConnected: Bool!

}
class MoviesListViewDelegateMock: MoviesListViewDelegate {

    //MARK: - update

    var updateWithCallsCount = 0
    var updateWithCalled: Bool {
        return updateWithCallsCount > 0
    }
    var updateWithReceivedViewState: MoviesListViewState?
    var updateWithReceivedInvocations: [MoviesListViewState] = []
    var updateWithClosure: ((MoviesListViewState) -> Void)?

    func update(with viewState: MoviesListViewState) {
        updateWithCallsCount += 1
        updateWithReceivedViewState = viewState
        updateWithReceivedInvocations.append(viewState)
        updateWithClosure?(viewState)
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
class RouterMock: Router {

    //MARK: - navigateToDetailsList

    var navigateToDetailsListCallsCount = 0
    var navigateToDetailsListCalled: Bool {
        return navigateToDetailsListCallsCount > 0
    }
    var navigateToDetailsListReceivedMovie: Movie?
    var navigateToDetailsListReceivedInvocations: [Movie] = []
    var navigateToDetailsListClosure: ((Movie) -> Void)?

    func navigateToDetailsList(_ movie: Movie) {
        navigateToDetailsListCallsCount += 1
        navigateToDetailsListReceivedMovie = movie
        navigateToDetailsListReceivedInvocations.append(movie)
        navigateToDetailsListClosure?(movie)
    }

}
class SystemNotificationMock: SystemNotification {

    //MARK: - addObserver

    var addObserverForNameObjectQueueUsingCallsCount = 0
    var addObserverForNameObjectQueueUsingCalled: Bool {
        return addObserverForNameObjectQueueUsingCallsCount > 0
    }
    var addObserverForNameObjectQueueUsingReceivedArguments: (name: NSNotification.Name?, obj: Any?, queue: OperationQueue?, block: (Notification) -> Void)?
    var addObserverForNameObjectQueueUsingReceivedInvocations: [(name: NSNotification.Name?, obj: Any?, queue: OperationQueue?, block: (Notification) -> Void)] = []
    var addObserverForNameObjectQueueUsingReturnValue: NSObjectProtocol!
    var addObserverForNameObjectQueueUsingClosure: ((NSNotification.Name?, Any?, OperationQueue?, @escaping (Notification) -> Void) -> NSObjectProtocol)?

    func addObserver(forName name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        addObserverForNameObjectQueueUsingCallsCount += 1
        addObserverForNameObjectQueueUsingReceivedArguments = (name: name, obj: obj, queue: queue, block: block)
        addObserverForNameObjectQueueUsingReceivedInvocations.append((name: name, obj: obj, queue: queue, block: block))
        return addObserverForNameObjectQueueUsingClosure.map({ $0(name, obj, queue, block) }) ?? addObserverForNameObjectQueueUsingReturnValue
    }

    //MARK: - removeObserver

    var removeObserverCallsCount = 0
    var removeObserverCalled: Bool {
        return removeObserverCallsCount > 0
    }
    var removeObserverReceivedObserver: Any?
    var removeObserverReceivedInvocations: [Any] = []
    var removeObserverClosure: ((Any) -> Void)?

    func removeObserver(_ observer: Any) {
        removeObserverCallsCount += 1
        removeObserverReceivedObserver = observer
        removeObserverReceivedInvocations.append(observer)
        removeObserverClosure?(observer)
    }

}
