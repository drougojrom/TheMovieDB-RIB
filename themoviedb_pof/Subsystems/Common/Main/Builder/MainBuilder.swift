//
//  MainBuilder.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 22.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol MainDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MainComponent: Component<MainDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    let mainViewController: MainViewController
    
    init(dependency: MainDependency,
         mainViewController: MainViewController) {
        self.mainViewController = mainViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener) -> MainRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: MainListener) -> MainRouting {
        let viewController = UIViewController.instantiateFromStoryboard("MainViewController") as! MainViewController
        let component = MainComponent(dependency: dependency, mainViewController: viewController)
        let interactor = MainInteractor(presenter: viewController)
        interactor.listener = listener
        
        let favoriteMoviesBuilder = FavoriteMoviesBuilder(dependency: component)
        let topMoviesBuilder = TopMoviesBuilder(dependency: component)
        let searchMovieBuilder = SearchMovieBuilder(dependency: component)
        let movieBuilder = MovieBuilder(dependency: component)
        
        let router =  MainRouter(interactor: interactor,
                                 viewController: viewController,
                                 favoriteMoviesBuilder: favoriteMoviesBuilder,
                                 topMoviesBuilder: topMoviesBuilder,
                                 searchMovieBuilder: searchMovieBuilder,
                                 movieBuilder: movieBuilder)
        
        return router
    }
}
