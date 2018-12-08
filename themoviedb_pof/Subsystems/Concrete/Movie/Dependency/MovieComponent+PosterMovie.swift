//
//  MovieComponent+PosterMovie.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 23.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the LoggedOut scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol MovieDependencyPosterMovie: Dependency {
    
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoggedOut scope.
}

extension MovieComponent: PosterMovieDependency {
    // TODO: Implement properties to provide for LoggedOut scope.
}
