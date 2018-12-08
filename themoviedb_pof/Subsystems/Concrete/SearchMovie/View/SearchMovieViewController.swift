//
//  SearchMovieViewController.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 27.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol SearchMoviePresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func searchQuery(_ text: String?)
    var movies: Movies? {get}
}

final class SearchMovieViewController: UIViewController, SearchMoviePresentable, SearchMovieViewControllable {

    @IBOutlet weak var tableView: UITableView!
    
    weak var listener: SearchMoviePresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("asd")
    }
    
    func reloadData() {
        
        tableView.reloadData()
    }
    
}

extension SearchMovieViewController {
    // MARK: actions
    
    @IBAction func searchFieldDidChange(_ sender: UITextField) {
        listener?.searchQuery(sender.text)
    }
}
