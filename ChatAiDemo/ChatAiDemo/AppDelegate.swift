//
//  AppDelegate.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/3/19.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller = ViewController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = CATabbarController()
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        return true
    }

}

