//
//  FavoriteMoviesRouter.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 03.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol FavoriteMoviesInteractable: Interactable {
    var router: FavoriteMoviesRouting? { get set }
    var listener: FavoriteMoviesListener? { get set }
}

protocol FavoriteMoviesViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FavoriteMoviesRouter: ViewableRouter<FavoriteMoviesInteractable, FavoriteMoviesViewControllable>, FavoriteMoviesRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: FavoriteMoviesInteractable,
                  viewController: FavoriteMoviesViewControllable) {
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
