//
//  LoggedInBuilder.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 22.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

protocol LoggedInDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var loggedInViewController: LoggedInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class LoggedInComponent: Component<LoggedInDependency> {
    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var loggedInViewController: LoggedInViewControllable {
        return dependency.loggedInViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {
    
    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: LoggedInListener) -> LoggedInRouting {
        let component = LoggedInComponent(dependency: dependency)
        let interactor = LoggedInInteractor()
        let mainBuilder = MainBuilder(dependency: component)
        interactor.listener = listener
        let router =  LoggedInRouter(interactor: interactor,
                                     viewController: component.loggedInViewController,
                                     mainBuilder: mainBuilder)
        return router
    }
}
