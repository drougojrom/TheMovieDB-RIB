//
//  FavoriteMoviesBuilder.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 03.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol FavoriteMoviesDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FavoriteMoviesComponent: Component<FavoriteMoviesDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FavoriteMoviesBuildable: Buildable {
    func build(withListener listener: FavoriteMoviesListener) -> FavoriteMoviesRouting
}

final class FavoriteMoviesBuilder: Builder<FavoriteMoviesDependency>, FavoriteMoviesBuildable {

    override init(dependency: FavoriteMoviesDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FavoriteMoviesListener) -> FavoriteMoviesRouting {
        let component = FavoriteMoviesComponent(dependency: dependency)
        let viewController = UIViewController.instantiateFromStoryboard(FavoriteMoviesConstants.ViewController) as! FavoriteMoviesViewController
        let interactor = FavoriteMoviesInteractor(presenter: viewController)
        interactor.listener = listener

        return FavoriteMoviesRouter(interactor: interactor,
                                    viewController: viewController)
    }
}
