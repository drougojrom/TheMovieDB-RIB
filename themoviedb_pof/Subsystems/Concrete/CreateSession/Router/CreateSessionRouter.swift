//
//  CreateSessionRouter.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 19.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol CreateSessionInteractable: Interactable {
    var router: CreateSessionRouting? { get set }
    var listener: CreateSessionListener? { get set }
}

protocol CreateSessionViewControllable: ViewControllable {

    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class CreateSessionRouter: ViewableRouter<CreateSessionInteractable, CreateSessionViewControllable>, CreateSessionRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: CreateSessionInteractable, viewController: CreateSessionViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func ShowAlertError(_ error: String) {
        SwiftyAlert.AlertHelper(stringMessage: error, vc: self.viewController.uiviewController)
    }
}
