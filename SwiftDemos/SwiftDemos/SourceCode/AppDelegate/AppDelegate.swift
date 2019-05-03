//
//  AppDelegate.swift
//  SwiftDemos
//
//  Created by Nitin A on 03/05/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let listController = DemoListController()
        let navigationController = UINavigationController(rootViewController: listController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

