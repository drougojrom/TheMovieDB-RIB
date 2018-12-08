//
//  PosterMovieInteractor.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 23.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol PosterMovieRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol PosterMoviePresentable: Presentable {
    var listener: PosterMoviePresentableListener? { get set }

    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol PosterMovieListener: class {
    func closePosterMovie()
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class PosterMovieInteractor: PresentableInteractor<PosterMoviePresentable>, PosterMovieInteractable, PosterMoviePresentableListener {
    
    weak var router: PosterMovieRouting?
    weak var listener: PosterMovieListener?
    
    private let posterMovie: UIImage

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: PosterMoviePresentable, posterMovie: UIImage) {
        self.posterMovie = posterMovie
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: PosterMoviePresentableListener
    
    func closePosterMovie() {
        listener?.closePosterMovie()
    }
    
    func setImage() -> UIImage {
        return posterMovie
    }
}
