//
//  LoggedOutRouter.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 18.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol LoggedOutInteractable: Interactable, CreateSessionListener {
    var router: LoggedOutRouting? { get set }
    var listener: LoggedOutListener? { get set }
}

protocol LoggedOutViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(view: ViewControllable)
    func dismiss(view: ViewControllable)
}

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>, LoggedOutRouting {
    
    // MARK: - Private
    private let createSessionBuilder: CreateSessionBuildable
    private var createSession: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedOutInteractable,
         viewController: LoggedOutViewControllable,
         createSessionBuilder: CreateSessionBuildable) {
        
        self.createSessionBuilder = createSessionBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func showAlertError(_ error: String) {
        SwiftyAlert.AlertHelper(stringMessage: error, vc: self.viewController as! UIViewController)
    }
    
    func routeToCreateSession() {
        let rib = createSessionBuilder.build(withListener: interactor)
        
        attachChild(rib)
        viewController.present(view: rib.viewControllable)
        
        createSession = rib
    }
    
    func closeCreateSession() {
        guard let child = self.createSession else { return }
    
        detachChild(child)
        viewController.dismiss(view: child.viewControllable)

        self.createSession = nil
    }
}
