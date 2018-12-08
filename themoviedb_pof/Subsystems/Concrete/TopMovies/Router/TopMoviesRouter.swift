//
//  TopMoviesRouter.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 27.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol TopMoviesInteractable: Interactable {
    var router: TopMoviesRouting? { get set }
    var listener: TopMoviesListener? { get set }
}

protocol TopMoviesViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TopMoviesRouter: ViewableRouter<TopMoviesInteractable, TopMoviesViewControllable>, TopMoviesRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TopMoviesInteractable, viewController: TopMoviesViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
