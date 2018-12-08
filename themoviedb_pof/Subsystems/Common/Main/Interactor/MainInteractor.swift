//
//  MainInteractor.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 22.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol MainRouting: ViewableRouting {
    func routeToFavoriteMovies()
    func routeToTopMovies()
    func routeToSearchMovie()
    func cleanupView(_ view: ViewableRouting?)
    func routeToMovie(idMovie: Int)
    var movieChildRib: ViewableRouting? { get }
    var tabbarChildRib: ViewableRouting? { get }
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MainListener: class {
    func closeMain()
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable, MainPresentableListener {
    
    weak var router: MainRouting?
    weak var listener: MainListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MainPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: MainPresentableListener
    
    func logoutUser(){
        User.logout()
        listener?.closeMain()
    }
    
    func changeRibsWithIndex(index: Int) {
        router?.cleanupView(router?.tabbarChildRib)
        let vcType = RoutToRib(rawValue: index)
        
        switch vcType {
        case .routToFavoriveMovies?:  router?.routeToFavoriteMovies()
        case .routToSearchMovie?: router?.routeToSearchMovie()
        case .routToTopMovies?: router?.routeToTopMovies()
        default:
            return
        }
    }
    
    func routToMovie(idMovie: Int) {
        router?.routeToMovie(idMovie: idMovie)
    }
    
    func closeMovie() {
        router?.cleanupView(router?.movieChildRib)
    }
}
