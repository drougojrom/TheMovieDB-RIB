//
//  AppDelegate.swift
//  themoviedb_pof
//
//  Created by Roman Ustiantcev on 18/04/2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import UIKit
import RIBs
import RealmSwift

var uiRealm: Realm!


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: - Private
    private var launchRouter: LaunchRouting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        launchRouter.launchFromWindow(window)
        setupRealm()
        return true
    }
    
    
    func setupRealm() {
        var configuration = Realm.Configuration.defaultConfiguration
        configuration.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = configuration
        uiRealm = try! Realm(configuration: configuration)
    }
}

