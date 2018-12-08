//
//  PosterMovieRouter.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 23.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol PosterMovieInteractable: Interactable {
    var router: PosterMovieRouting? { get set }
    var listener: PosterMovieListener? { get set }
}

protocol PosterMovieViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PosterMovieRouter: ViewableRouter<PosterMovieInteractable, PosterMovieViewControllable>, PosterMovieRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: PosterMovieInteractable, viewController: PosterMovieViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
