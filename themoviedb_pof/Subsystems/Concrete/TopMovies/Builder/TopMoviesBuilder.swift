//
//  TopMoviesBuilder.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 27.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol TopMoviesDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class TopMoviesComponent: Component<TopMoviesDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol TopMoviesBuildable: Buildable {
    func build(withListener listener: TopMoviesListener) -> TopMoviesRouting
}

final class TopMoviesBuilder: Builder<TopMoviesDependency>, TopMoviesBuildable {
    
    override init(dependency: TopMoviesDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TopMoviesListener) -> TopMoviesRouting {
        let component = TopMoviesComponent(dependency: dependency)
        let viewController = UIViewController.instantiateFromStoryboard(topMoviesConstants.ViewController) as! TopMoviesViewController
        let interactor = TopMoviesInteractor(presenter: viewController)
        interactor.listener = listener
        let router = TopMoviesRouter(interactor: interactor, viewController: viewController)
        
        return router
    }
}
