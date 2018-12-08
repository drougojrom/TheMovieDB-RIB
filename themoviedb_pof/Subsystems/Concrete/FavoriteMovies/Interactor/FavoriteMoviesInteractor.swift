//
//  FavoriteMoviesInteractor.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 03.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol FavoriteMoviesRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol FavoriteMoviesPresentable: Presentable {
    var listener: FavoriteMoviesPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func reloadData()
}

protocol FavoriteMoviesListener: class {
    func routToMovie(idMovie: Int)
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FavoriteMoviesInteractor: PresentableInteractor<FavoriteMoviesPresentable>, FavoriteMoviesInteractable, FavoriteMoviesPresentableListener {
    
    weak var router: FavoriteMoviesRouting?
    weak var listener: FavoriteMoviesListener?
    
    private let notificationName = Notification.Name(FavoriteMoviesConstants.Notification)
    
    lazy var favoriteMoviesService = FavoriteMoviesService()
    
    var movies: [Movie]? = [Movie]() {
        didSet {
            presenter.reloadData()
        }
    }
    
    private var favoriteMoviesId = [Int]()
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FavoriteMoviesPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        getFavoriteMovies()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification), name: notificationName, object: nil)
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        self.movies = Movie.getFavoriteMovies()
    }
    
    // MARK: FavoriteMoviesPresentableListener
    
    func routToMovie(idMovie: Int){
        if let movie = movies?[idMovie] {
            listener?.routToMovie(idMovie: movie.id)
        }
    }
    
    func setUsername() -> String {
        return User.getCurrentUser().username ?? String()
    }
    
    func getNumberOfRow() -> Int {
        return movies?.count ?? 0
    }
    
    // MARK: PRIVATE
    
    private func getFavoriteMovies() {
        favoriteMoviesService.getFavoriteMovies(completionHandler: { [weak self] movies in
            self?.movies = movies
        }, errorHandler: { (error) in
            print("error getFavoriteMovies \(error!)")
        })
    }
}
