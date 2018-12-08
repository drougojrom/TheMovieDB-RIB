//
//  FavoriteMoviesViewController.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 03.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs
import UIKit

protocol FavoriteMoviesPresentableListener: class {
    var movies: [Movie]? { get }
    func setUsername() -> String
    func getNumberOfRow() -> Int
    func routToMovie(idMovie: Int)
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class FavoriteMoviesViewController: UIViewController, FavoriteMoviesPresentable, FavoriteMoviesViewControllable {

    weak var listener: FavoriteMoviesPresentableListener?
    
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLable.text = listener?.setUsername()
    }

    // MARK: FavoriteMoviesPresentable
    
    func reloadData() {
        tableView.reloadData()
    }
}
