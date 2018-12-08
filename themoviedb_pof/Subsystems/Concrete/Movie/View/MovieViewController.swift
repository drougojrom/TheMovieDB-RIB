//
//  MovieViewController.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 04.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs
import UIKit

protocol MoviePresentableListener: class {
    func markMovieAsFavorite()
    func routToPosterMovie()
    func closeMovie()
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class MovieViewController: UIViewController, MoviePresentable, MovieViewControllable {
    
    weak var listener: MoviePresentableListener?
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var posterButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    // MARK: MoviePresentable
    
    func setImage(imagePath: String) {
        movieImage.setMovieImage(imagePath)
    }
    
    func setTitle(_ title: String) {
        originalTitleLabel.text = title
    }
    
    func setDate(_ date: String) {
        releaseDateLabel.text = date
    }
    
    func setTagline(_ tagline: String) {
        taglineLabel.text = tagline
    }
    
    func setVoteAverage(_ voteAverage: String) {
        voteAverageLabel.text = voteAverage
    }
    
    func setVoteCount(_ voteCount: String) {
        voteCountLabel.text = voteCount
    }
    
    func setGenres(_ genres: String) {
        genresLabel.text = genres
    }
    
    func setOverview(_ overview: String) {
        overviewTextView.text = overview
    }
    
    func setFavoriteButton(isFavorite: Bool) {
        self.favoriteButton.isSelected = isFavorite
    }
    
    // MARK: MovieViewControllable
    func presentWithNavController(viewController: ViewControllable) {
        navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
}

extension MovieViewController {
    
    @IBAction func favoriteButtonTapped(sender: UIButton) {
        listener?.markMovieAsFavorite()
    }
    
    @IBAction func posterButtonTapped(sender: UIButton) {
        listener?.routToPosterMovie()
    }
    
    @IBAction func backBarButtonTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        listener?.closeMovie()
    }
}
