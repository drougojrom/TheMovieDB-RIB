//
//  SearchMovieBuilder.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 27.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol SearchMovieDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchMovieComponent: Component<SearchMovieDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

protocol SearchMovieBuildable: Buildable {
    func build(withListener listener: SearchMovieListener) -> SearchMovieRouting
}

final class SearchMovieBuilder: Builder<SearchMovieDependency>, SearchMovieBuildable {
    
    override init(dependency: SearchMovieDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: SearchMovieListener) -> SearchMovieRouting {
        let component = SearchMovieComponent(dependency: dependency)
        
        let storyboard = UIStoryboard(name: "SearchMovieViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchMovieViewController") as! SearchMovieViewController
        
        let interactor = SearchMovieInteractor(presenter: viewController)
        interactor.listener = listener
        let router = SearchMovieRouter(interactor: interactor, viewController: viewController)
        
        return router
    }
}
