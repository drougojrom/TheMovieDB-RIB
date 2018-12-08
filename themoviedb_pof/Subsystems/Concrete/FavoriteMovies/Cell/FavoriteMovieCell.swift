//
//  FavoriteMovieCell.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 04.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import UIKit

class FavoriteMovieCell: UITableViewCell {
    
    @IBOutlet weak var favoriteMovieImage: UIImageView!
    @IBOutlet weak var favoriteMovieLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteMovieLabel.text = nil
        favoriteMovieImage.image = nil
    }
    
    func setMovieImage(_ image: String) {
        favoriteMovieImage.setMovieImage(image)
    }
    
    func setMovieLabel(_ text: String) {
        favoriteMovieLabel.text = text
    }
}
