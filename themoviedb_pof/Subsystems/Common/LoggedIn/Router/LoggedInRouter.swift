//
//  LoggedInRouter.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 22.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, MainListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
    
    // MARK: Private
    private let viewController: LoggedInViewControllable
    
    private let mainBuilder: MainBuildable
    private var mainChild: MainRouting?
    
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         mainBuilder: MainBuilder) {
        self.viewController = viewController
        self.mainBuilder = mainBuilder
        
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    // MARK: - LoggedInRouting
    
    func routeToMain() {
        let rib = mainBuilder.build(withListener: interactor)
        self.mainChild = rib
        attachChild(rib)
        let navController = UINavigationController(root: rib.viewControllable)
        viewController.present(viewController: navController)
    }
    
    func cleanupView() {
        if let child = mainChild {
            viewController.dismiss(viewController: child.viewControllable)
            detachChild(child)
            return
        }
    }
}
