//
//  AppDelegate.swift
//  DCUProject
//
//  Created by PRO on 12/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator()
        self.window?.rootViewController = appCoordinator.navigationController
        self.window?.makeKeyAndVisible()
        appCoordinator.start()
        
        return true
    }
}

