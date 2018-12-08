//
//  RootComponent+LoggedIn.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 22.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the LoggedIn scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyLoggedIn: Dependency {
    
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoggedIn scope.
}

extension RootComponent: LoggedInDependency {
    var loggedInViewController: LoggedInViewControllable {
        return rootViewController
    }
}
