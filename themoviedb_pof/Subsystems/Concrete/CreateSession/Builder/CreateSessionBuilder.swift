//
//  CreateSessionBuilder.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 19.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol CreateSessionDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class CreateSessionComponent: Component<CreateSessionDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol CreateSessionBuildable: Buildable {
    func build(withListener listener: CreateSessionListener) -> CreateSessionRouting
}

final class CreateSessionBuilder: Builder<CreateSessionDependency>, CreateSessionBuildable {
    
    override init(dependency: CreateSessionDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: CreateSessionListener) -> CreateSessionRouting {
        let viewController = UIViewController.instantiateFromStoryboard(CreateSessionConstants.viewController) as! CreateSessionViewController
        let interactor = CreateSessionInteractor(presenter: viewController)
        interactor.listener = listener
        return CreateSessionRouter(interactor: interactor,
                                   viewController: viewController)
    }
}
