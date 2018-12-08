
//
//  SearchMovieCell.swift
//  themoviedb_pof
//
//  Created by Roman Ustiantcev on 03/05/2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import UIKit
import Kingfisher

class SearchMovieCell: UITableViewCell {
    
    @IBOutlet weak var foundMovieImage: UIImageView!
    @IBOutlet weak var foundMovieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setMovieImage(_ image: String) {
        if let url = URL(string: ClientConfig.ImageURL + image) {
            foundMovieImage.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(ImageTransition.fade(0.25))],
                                  progressBlock: nil,
                                  completionHandler: { image, error, cacheType, imageURL in
            })
        }
    }
    
    func setMovieLabel(_ text: String) {
        foundMovieLabel.text = text
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        foundMovieImage.image = nil
        foundMovieLabel.text = nil
    }

}
