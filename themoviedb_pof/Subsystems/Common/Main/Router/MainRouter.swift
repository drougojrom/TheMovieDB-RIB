//
//  MainRouter.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 22.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol MainInteractable: Interactable, FavoriteMoviesListener, TopMoviesListener, SearchMovieListener, MovieListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func presentWithNavController(viewController: ViewControllable)
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {
    
    // MARK: - Private
    private let favoriteMoviesBuilder: FavoriteMoviesBuildable
    private let topMoviesBuilder: TopMoviesBuildable
    private let searchMovieBuilder: SearchMovieBuildable
    private let movieBuilder: MovieBuildable
    
    var movieChildRib: ViewableRouting?
    var tabbarChildRib: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: MainInteractable,
         viewController: MainViewControllable,
         favoriteMoviesBuilder: FavoriteMoviesBuildable,
         topMoviesBuilder: TopMoviesBuildable,
         searchMovieBuilder: SearchMovieBuildable,
         movieBuilder: MovieBuildable) {
        
        self.favoriteMoviesBuilder = favoriteMoviesBuilder
        self.topMoviesBuilder = topMoviesBuilder
        self.searchMovieBuilder = searchMovieBuilder
        self.movieBuilder = movieBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: MainRouting
    
    func routeToFavoriteMovies() {
        let rib = favoriteMoviesBuilder.build(withListener: interactor)
        attachChildRib(rib: rib)
    }
    
    func routeToTopMovies() {
        let rib = topMoviesBuilder.build(withListener: interactor)
        attachChildRib(rib: rib)
    }
    
    func routeToSearchMovie() {
        let rib = searchMovieBuilder.build(withListener: interactor)
        attachChildRib(rib: rib)
    }
    
    func cleanupView(_ view: ViewableRouting?) {
        if let child = view {
            detachChild(child)
        }
    }
    
    func routeToMovie(idMovie: Int) {
        let rib = movieBuilder.build(withListener: interactor, idMovie: idMovie)
        attachChild(rib)
        viewController.presentWithNavController(viewController: rib.viewControllable)
        self.movieChildRib = rib
    }

    private func attachChildRib(rib: ViewableRouting) {
        attachChild(rib)
        tabbarChildRib = rib
        viewController.present(viewController: tabbarChildRib!.viewControllable)
    }
}
