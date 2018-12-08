//
//  ImageHelper.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 07.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import Kingfisher

extension UIImageView {
    func setMovieImage(_ image: String) {
        if let url = URL(string: ClientConfig.ImageURL + image) {
            kf.setImage(with: url,
                        placeholder: nil,
                        options: [.transition(ImageTransition.fade(0.25))],
                        progressBlock: nil,
                        completionHandler: { image, error, cacheType, imageURL in
            })
        }
    }
}
