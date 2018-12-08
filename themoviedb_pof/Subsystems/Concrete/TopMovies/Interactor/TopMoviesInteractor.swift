//
//  TopMoviesInteractor.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 27.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs
import RxSwift

protocol TopMoviesRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TopMoviesPresentable: Presentable {
    var listener: TopMoviesPresentableListener? { get set }
    func initSubscribe()
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol TopMoviesListener: class {
    func routToMovie(idMovie: Int)
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class TopMoviesInteractor: PresentableInteractor<TopMoviesPresentable>, TopMoviesInteractable, TopMoviesPresentableListener {
    
    weak var router: TopMoviesRouting?
    weak var listener: TopMoviesListener?

    lazy var topMoviesService = TopMoviesService()
    
    private var indexOfPageRequest = 1
    
    // MARK: TopMoviesPresentableListener variables
    
    var moviesArray: Variable<[MovieProtocol]> = Variable<[MovieProtocol]>([])
    var shouldLoadNextPage: Bool = false

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: TopMoviesPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        getTopMoviesOnPage(indexOfPageRequest)
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: TopMoviesPresentableListener
    
    func getNewData() {
        indexOfPageRequest += 1
        getTopMoviesOnPage(indexOfPageRequest)
    }
    
    func routToMovie(idMovie: Int) {
        listener?.routToMovie(idMovie: idMovie)
    }
    
    // MARK: private
    
    private func getTopMoviesOnPage(_ page: Int) {
        shouldLoadNextPage = false
        topMoviesService.getTopMoviesServiceOnPage(page, completionHandler: { [weak self] (topMovies) in
            self?.setMovieDetailView(topMovies)
            } , errorHandler: { (error) in
                print("error getTopMoviesServiceOnPage \(error!)")
        })
    }
    
    private func setMovieDetailView(_ movies: Movies?) {
        
        guard let movies = movies?.results else { return }
        
        moviesArray.value.append(contentsOf: movies)
        if indexOfPageRequest == 1 {
            presenter.initSubscribe()
        }
        shouldLoadNextPage = true
    }
}
