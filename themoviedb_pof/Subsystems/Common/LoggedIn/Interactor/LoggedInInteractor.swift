//
//  LoggedInInteractor.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 22.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol LoggedInRouting: Routing {
    func cleanupView()
    func routeToMain()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedInListener: class {
    func closeLoggedIn()
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {
   
    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {
        super.init()
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        DispatchQueue.main.async(){
            self.router?.routeToMain()
        }
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func closeMain() {
        router?.cleanupView()
        listener?.closeLoggedIn()
    }
}
