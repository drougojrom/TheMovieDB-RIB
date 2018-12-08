//
//  LoggedInComponent+Main.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 22.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the LoggedOut scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol LoggedInDependencyMain: Dependency {
    
    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the child scope.
}

extension LoggedInComponent: MainDependency {
    // TODO: Implement properties to provide for AccountSelection scope.
}
