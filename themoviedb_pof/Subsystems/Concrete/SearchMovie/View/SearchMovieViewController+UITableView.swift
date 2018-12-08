//
//  SearchMovieViewController+UITableView.swift
//  themoviedb_pof
//
//  Created by Roman Ustiantcev on 03/05/2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import UIKit

extension SearchMovieViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = listener?.movies?.results {
            return movies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieConstants.searchMovieCellId, for: indexPath) as! SearchMovieCell
        
        if let movie = listener?.movies?.results?[indexPath.row] {
            if let poster = movie.posterPath {
                cell.setMovieImage(poster)
            }
            
            if let movieName = movie.originalTitle {
                cell.setMovieLabel(movieName)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension SearchMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: implement detail view for movie with id
    }
}
