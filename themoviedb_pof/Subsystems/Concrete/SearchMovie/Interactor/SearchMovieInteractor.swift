//
//  SearchMovieInteractor.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 27.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol SearchMovieRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchMoviePresentable: Presentable {
    var listener: SearchMoviePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func reloadData()
}

protocol SearchMovieListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchMovieInteractor: PresentableInteractor<SearchMoviePresentable>, SearchMovieInteractable, SearchMoviePresentableListener {
        
    weak var router: SearchMovieRouting?
    weak var listener: SearchMovieListener?
    
    lazy var searchService = SearchService()
    var movies: Movies? = Movies() {
        didSet {
            presenter.reloadData()
        }
    }

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchMoviePresentable) {
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
    
    func searchQuery(_ text: String?) {
        searchService.searchMovies([ClientConfig.ParameterKeys.ApiKey: ClientConfig.ApiKey,
                                    "query": text!], completionHandler: { [weak self](movies) in
            print(movies)
            self?.movies = movies
        }) { (error) in
            print(error?.description as Any)
        }
    }
}
