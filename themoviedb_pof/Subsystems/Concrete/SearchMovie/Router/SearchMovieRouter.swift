//
//  SearchMovieRouter.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 27.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol SearchMovieInteractable: Interactable {
    var router: SearchMovieRouting? { get set }
    var listener: SearchMovieListener? { get set }
}

protocol SearchMovieViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchMovieRouter: ViewableRouter<SearchMovieInteractable, SearchMovieViewControllable>, SearchMovieRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchMovieInteractable, viewController: SearchMovieViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
