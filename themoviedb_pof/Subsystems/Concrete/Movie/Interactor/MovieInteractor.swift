//
//  MovieInteractor.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 04.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs
import Kingfisher

protocol MovieRouting: ViewableRouting {
    func showAlertError(_ error: String)
    func routToMoviePoster(_ posterMovie: UIImage)
    func closePosterMovie()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MoviePresentable: Presentable {
    var listener: MoviePresentableListener? { get set }
    func setImage(imagePath: String)
    func setTitle(_ title: String)
    func setDate(_ date: String)
    func setTagline(_ tagline: String)
    func setVoteAverage(_ voteAverage: String)
    func setVoteCount(_ voteCount: String)
    func setGenres(_ genres: String)
    func setOverview(_ overview: String)
    func setFavoriteButton(isFavorite: Bool)
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MovieListener: class {
    func closeMovie()
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MovieInteractor: PresentableInteractor<MoviePresentable>, MovieInteractable, MoviePresentableListener {
    
    weak var router: MovieRouting?
    weak var listener: MovieListener?
    
    lazy var movieDetailService = MovieDetailService()
    lazy var favoriteMoviesService = FavoriteMoviesService()
    
    private let notificationName = Notification.Name(FavoriteMoviesConstants.Notification)
    private let idMovie: Int
    private var isFavorite = false
    private var movieData: Movie? = Movie() {
        didSet {
            setMovieData()
        }
    }
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: MoviePresentable, idMovie: Int) {
        self.idMovie = idMovie
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        getMovie()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: MoviePresentableListener
    
    func markMovieAsFavorite() {
        isFavorite = !isFavorite
        presenter.setFavoriteButton(isFavorite: (isFavorite))
        setMovieAsFavorite()
    }
    
    func routToPosterMovie() {
        routToPoster()
    }
    
    func closeMovie() {
        listener?.closeMovie()
    }
    
    // MARK: PosterMovieListener
    
    func closePosterMovie() {
        router?.closePosterMovie()
    }
    
    // MARK: private
    
    private func setMovieData() {
        if let movie = movieData {
            
            if let image = movie.posterPath {
                presenter.setImage(imagePath: image)
            }
            
            if let title = movie.originalTitle {
                presenter.setTitle(title)
            }
            
            if let date = movie.releaseDate {
                presenter.setDate(date)
            }
            
            if let tagline = movie.tagline {
                presenter.setTagline(tagline)
            }
            
            presenter.setVoteAverage("Vote Average: \(movie.voteAverage)")
            presenter.setVoteCount("Vote Count: \(movie.voteCount)")
            
            if let genres = movie.genres {
                presenter.setGenres(genres.compactMap{ $0.name }.joined(separator: ", "))
            }
            
            if let overview = movie.overview {
                presenter.setOverview(overview)
            }
            
            isFavorite = Movie.isFavorite(movie: movie)
            presenter.setFavoriteButton(isFavorite: isFavorite)
        }
    }
    
    private func getMovie() {
        movieDetailService.getMovieWithId(String(idMovie), completionHandler: { [weak self] (movie) in
            self?.movieData = movie
            }, errorHandler: { (error) in
                print("error getMovie \(error!)")
        })
    }
    
    private func setMovieAsFavorite() {
        let json: [String : Any] = [ MovieConstants.Parameter.MediaType: MovieConstants.Parameter.Movie,
                                     MovieConstants.Parameter.MediaId: idMovie,
                                     MovieConstants.Parameter.Favorite: isFavorite ]
        markAsFavorite(body: json)
        isFavorite ? Movie.addNewFavoriteMovie(movieData!) : Movie.removeFavoriteMovie(movieData!)
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
    
    private func markAsFavorite(body: [String : Any]) {
        favoriteMoviesService.markAsFavorite(body: body, errorHandler: { [weak self] error in
            guard let strongSelf = self else { return }
            if let errorText = error {
                strongSelf.router?.showAlertError(errorText)
                strongSelf.presenter.setFavoriteButton(isFavorite: (strongSelf.isFavorite))
            }
        })
    }
    
    private func routToPoster() {
        if let imagePath = movieData?.posterPath {
            let url = URL(string: ClientConfig.ImageURL + imagePath)
            ImageDownloader.default.downloadImage(with: url!, options: [], progressBlock: nil) {
                (image, error, url, data) in
                if let posterImage = image {
                    self.router?.routToMoviePoster(posterImage)
                } else {
                    print(MovieConstants.RoutToPosterMovieError)
                }
            }
        }
    }
}
