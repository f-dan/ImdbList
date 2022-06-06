//
//  ListMovieViewModel.swift
//  ImdbList
//
//  Created by Danilo on 11/05/22.
//

import Foundation

protocol MoviesListCoordinatorDelegate: AnyObject {
    func openDescriptionMovies(trailer: Trailer)
    func goHome()
}

protocol MoviesListViewDelegate: AnyObject {
    func onSuccess()
    func onFailure()
}

final class MoviesListViewModel{
    
    var currentResult: Search!
    var trailer: Trailer!
    weak var flowDelegate: MoviesListCoordinatorDelegate!
    weak var vcDelegate: MoviesListViewDelegate!
    private var service: ImdbAPI
    
    lazy var count: Int = {
        return currentResult.results.count
    }()
    
    init(service: ImdbAPI, movies: Search) {
        self.service = service
        self.currentResult = movies
    }
    
    func movieBy(_ indexPath: IndexPath) ->  Result {
        return currentResult.results[indexPath.row]
    }
    
    func goToMovieDescription(trailer: Trailer) {
        flowDelegate?.openDescriptionMovies(trailer: self.trailer)
    }
    
    func fetchTrailer(_ indexPath: IndexPath){
        let id = currentResult.results[indexPath.row].id
        service.requestTrailer(videoID: id) { [weak self] result in
            guard let self = self, let result = result else { return }
            self.trailer = result
            self.vcDelegate?.onSuccess()
            self.goToMovieDescription(trailer: self.trailer)
        }
    }
    
}



