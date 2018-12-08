//
//  PosterMovieBuilder.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 23.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol PosterMovieDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class PosterMovieComponent: Component<PosterMovieDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol PosterMovieBuildable: Buildable {
    func build(withListener listener: PosterMovieListener, posterMovie: UIImage) -> PosterMovieRouting
}

final class PosterMovieBuilder: Builder<PosterMovieDependency>, PosterMovieBuildable {

    override init(dependency: PosterMovieDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: PosterMovieListener, posterMovie: UIImage) -> PosterMovieRouting {
        let viewController = UIViewController.instantiateFromStoryboard(PosterMovieConstants.ViewController) as! PosterMovieViewController
        let component = PosterMovieComponent(dependency: dependency)
        let interactor = PosterMovieInteractor(presenter: viewController, posterMovie: posterMovie)
        interactor.listener = listener
        return PosterMovieRouter(interactor: interactor, viewController: viewController)
    }
}
