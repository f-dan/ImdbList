//
//  MoviesViewModel.swift
//  ImdbList
//
//  Created by Danilo on 04/05/22.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func openListMovieView(movies: Search)
}

protocol HomeViewDelegate: AnyObject {
    func loading()
    func onSuccess()
    func onFailure()
}

final class HomeViewModel {
    
    var currentResult: Search!
    weak var flowDelegate: HomeCoordinatorDelegate!
    weak var vcDelegate: HomeViewDelegate!
    private var service: ImdbAPI
    
    init(service: ImdbAPI) {
        self.service = service
    }

    func goToList(movies: Search) {
        flowDelegate?.openListMovieView(movies: self.currentResult)
    }
    
    func fetchMovies(search: String){
        vcDelegate.loading()
        service.requestMovie(movieName: search) { [weak self] result in
            guard let self = self, let result = result else { return }
            self.currentResult = result
            self.vcDelegate?.onSuccess()
            self.goToList(movies: result)
        }
    }
}
