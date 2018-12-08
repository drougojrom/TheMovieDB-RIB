//
//  TopMoviesCell.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 10.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import UIKit

class TopMoviesCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewMovieLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleMovieLabel.text = nil
        overviewMovieLabel.text = nil
        movieImage.image = nil
    }
    
    func setMovieData(_ movie: MovieProtocol) {
        let defaultString = String()
        setMovieImage(movie.posterPath ?? defaultString)
        setTitleLabel(movie.originalTitle ?? defaultString)
        setOverviewLabel(movie.overview ?? defaultString)
    }
    
    private func setMovieImage(_ image: String) {
        movieImage.setMovieImage(image)
    }
    
    private func setTitleLabel(_ text: String) {
        titleMovieLabel.text = text
    }
    
    private func setOverviewLabel(_ text: String) {
        overviewMovieLabel.text = text
    }
}
