//
//  ImdbCoordinator.swift
//  ImdbList
//
//  Created by Danilo on 09/05/22.
//

import Foundation
import UIKit

final class ImdbCoordinator: Coordinator {
    typealias V = HomeViewController
    var view: HomeViewController?
    var navigation: UINavigationController!
    
    func start() -> V {
        let viewModel = HomeViewModel(service: ImdbAPI())
        viewModel.flowDelegate = self
        view = HomeViewController(viewModel: viewModel)
        return view!
    }
    
    func stop() {
        view = nil
        navigation = nil
    }
    
    func createMoviesView(movies:Search) {
        let moviesViewModel = MoviesListViewModel(service: ImdbAPI(), movies: movies)
        let resultVc = MoviesListViewController(viewModel: moviesViewModel)
        moviesViewModel.flowDelegate = self
        resultVc.modalPresentationStyle = .overFullScreen
        navigation.pushViewController(resultVc, animated: true)
    }
    
    func openMoviesDescription(trailer:Trailer) {
        let moviesViewModel = MoviesDescriptionViewModel(service: ImdbAPI(), trailer: trailer)
        let trailerVc = MoviesDescriptionViewController(viewModel: moviesViewModel)
        trailerVc.modalPresentationStyle = .overFullScreen
        navigation.pushViewController(trailerVc, animated: true)
    }
    
    func goBack() {
        navigation.popViewController(animated: true)
    }
    
}

extension ImdbCoordinator: HomeCoordinatorDelegate {
    func openListMovieView(movies: Search){
        createMoviesView(movies: movies)
    }
}

extension ImdbCoordinator: MoviesListCoordinatorDelegate {
    func openDescriptionMovies(trailer: Trailer) {
        openMoviesDescription(trailer: trailer)
    }
    
    func goHome(){
        goBack()
    }
}
