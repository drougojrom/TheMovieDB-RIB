//
//  TopMoviesViewController.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 27.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs
import UIKit
import RxCocoa
import RxSwift

protocol TopMoviesPresentableListener: class {
    var moviesArray: Variable<[MovieProtocol]> { get }
    var shouldLoadNextPage: Bool { get }
    func getNewData()
    func routToMovie(idMovie: Int)
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TopMoviesViewController: UIViewController, TopMoviesPresentable, TopMoviesViewControllable {
    
    weak var listener: TopMoviesPresentableListener?
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rx.modelSelected(MovieProtocol.self)
            .subscribe(onNext: { [weak self] element in
                self?.listener?.routToMovie(idMovie: element.id)
            })
            .disposed(by: disposeBag)
        
        
        tableView?.rx.contentOffset
            .subscribe { [weak self] offset in
                guard let shouldLoadNextPage = self?.listener?.shouldLoadNextPage else { return }
                if shouldLoadNextPage {
                    if (self?.tableView.isNearBottomEdge(edgeOffset: 20.0))! {
                        self?.listener?.getNewData()
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: TopMoviesPresentable
    func initSubscribe() {
        let movies = self.listener?.moviesArray
        movies?.asObservable().bind(to: tableView.rx.items(cellIdentifier: topMoviesConstants.Cell)) { (row, element, cell) in
            if let cellToUse = cell as? TopMoviesCell {
                cellToUse.setMovieData(element)
            }
        }
        .disposed(by: disposeBag)
    }
}
