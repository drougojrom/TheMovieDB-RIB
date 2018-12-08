//
//  LoggedOutBuilder.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 18.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol LoggedOutDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LoggedOutComponent: Component<LoggedOutDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {
    
    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        let component = LoggedOutComponent(dependency: dependency)
        let viewController = UIViewController.instantiateFromStoryboard(LoggedOutConstants.viewController) as! LoggedOutViewController
        let interactor = LoggedOutInteractor(presenter: viewController)
        interactor.listener = listener
        let createSessionBuilder = CreateSessionBuilder(dependency: component)
        
        return LoggedOutRouter(interactor: interactor,
                               viewController: viewController,
                               createSessionBuilder: createSessionBuilder)
    }
}
