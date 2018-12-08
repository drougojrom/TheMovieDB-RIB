//
//  LoggedOutInteractor.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 18.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol LoggedOutRouting: ViewableRouting {
    func routeToCreateSession()
    func closeCreateSession()
    func showAlertError(_ error: String)
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func showTitle(_ title: String)
    
}

protocol LoggedOutListener: class {
    func closeLoggedOut()
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {

    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?
    
    lazy var authNetworkService = AuthNetworkService()
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoggedOutPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        presenter.showTitle("Log In")
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - CreateSessionListener
    
    func closeCreateSession() {
        self.router?.closeCreateSession()
        self.listener?.closeLoggedOut()
    }
    
    // MARK: - LoggedOutPresentableListener
    
    func getToken() {
        authNetworkService.createRequestToken( completionHandler: { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async() {
                strongSelf.router?.routeToCreateSession()
            }
            }, errorHandler: { [weak self] error in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async(){
                    if let errorText = error {
                        strongSelf.router?.showAlertError(errorText)
                    }
                }
        })
    }
}
