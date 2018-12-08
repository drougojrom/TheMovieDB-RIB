//
//  MovieBuilder.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 04.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol MovieDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MovieComponent: Component<MovieDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MovieBuildable: Buildable {
    func build(withListener listener: MovieListener, idMovie: Int) -> MovieRouting
}

final class MovieBuilder: Builder<MovieDependency>, MovieBuildable {

    override init(dependency: MovieDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MovieListener, idMovie: Int) -> MovieRouting {
        let component = MovieComponent(dependency: dependency)
        let viewController = UIViewController.instantiateFromStoryboard(MovieConstants.ViewController) as! MovieViewController
        let interactor = MovieInteractor(presenter: viewController, idMovie: idMovie)
        interactor.listener = listener
        let posterMovieBuilder = PosterMovieBuilder(dependency: component)
        
        return MovieRouter(interactor: interactor,
                           viewController: viewController,
                           posterMovieBuilder: posterMovieBuilder)
    }
}
