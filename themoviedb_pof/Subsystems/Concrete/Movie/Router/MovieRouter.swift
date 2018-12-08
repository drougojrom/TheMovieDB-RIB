//
//  MovieRouter.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 04.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol MovieInteractable: Interactable, PosterMovieListener {
    weak var router: MovieRouting? { get set }
    weak var listener: MovieListener? { get set }
}

protocol MovieViewControllable: ViewControllable {
    func presentWithNavController(viewController: ViewControllable)
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MovieRouter: ViewableRouter<MovieInteractable, MovieViewControllable>, MovieRouting {
    
    // MARK: - Private
    private let posterMovieBuilder: PosterMovieBuildable
    private var childRib: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: MovieInteractable,
         viewController: MovieViewControllable,
         posterMovieBuilder: PosterMovieBuildable) {
        
        self.posterMovieBuilder = posterMovieBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func showAlertError(_ error: String) {
        SwiftyAlert.AlertHelper(stringMessage: error, vc: self.viewController.uiviewController)
    }
    
    func routToMoviePoster(_ posterMovie: UIImage) {
        let rib = posterMovieBuilder.build(withListener: interactor, posterMovie: posterMovie)
        attachChild(rib)
        viewController.presentWithNavController(viewController: rib.viewControllable)
        self.childRib = rib
    }
    
    func closePosterMovie() {
        guard let child = self.childRib else { return }
        detachChild(child)
        self.childRib = nil
    }
}
