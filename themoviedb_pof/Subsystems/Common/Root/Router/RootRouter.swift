//
//  RootRouter.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 18.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // MARK: - Private
    private let loggedOutBuilder: LoggedOutBuildable
    private let loggedInBuilder: LoggedInBuildable
    
    private var loggedOut: ViewableRouting?
    private var loggedIn: Routing?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable,
         loggedInBuilder: LoggedInBuildable) {
        
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        DispatchQueue.main.async {
            if let _ = User.getCurrentUser().session_id {
                self.routeToLoggedIn()
            } else {
                self.routeToLoggedOut()
            }
        }
    }
    
    func routeToLoggedIn() {
        // Detach logged out
        if let child = self.loggedOut {
            detachChild(child)
            viewController.dismiss(viewController: child.viewControllable)
            self.loggedOut = nil
        }
        if loggedIn == nil {
            loggedIn = loggedInBuilder.build(withListener: interactor)
        }
        
        guard let loggedIn = self.loggedIn else { fatalError("failed to allocate rib") }
        attachChild(loggedIn)
    }
    
    func routeToLoggedOut() {
        // Detach logged in
        if let child = self.loggedIn {
            detachChild(child)
            self.loggedIn = nil
        }
        
        if loggedOut == nil {
            loggedOut = loggedOutBuilder.build(withListener: interactor)
        }
        guard let loggedOut = self.loggedOut else { fatalError("failed to allocate rib") }
    
        attachChild(loggedOut)
        let navController = UINavigationController(root: loggedOut.viewControllable)
        viewController.present(viewController: navController)
    }
}
