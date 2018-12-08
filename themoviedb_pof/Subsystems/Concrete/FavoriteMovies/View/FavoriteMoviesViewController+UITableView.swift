//
//  FavoriteMoviesViewController+UITableView.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 05.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import UIKit

extension FavoriteMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FavoriteMoviesConstants.SectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listener!.getNumberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMoviesConstants.Cell, for: indexPath) as! FavoriteMovieCell
        if let movie = listener?.movies?[indexPath.row] {
            
            if let poster = movie.posterPath {
                cell.setMovieImage(poster)
            }
            
            if let movieName = movie.originalTitle {
                cell.setMovieLabel(movieName)
            }
        }
        
        return cell
    }
}

extension FavoriteMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.routToMovie(idMovie: indexPath.row)
    }
}
