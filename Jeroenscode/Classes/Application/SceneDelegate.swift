//
//  SceneDelegate.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import UIKit
import SwiftUI
import Presentation

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private let appAssembly: AppAssembly = AppAssembly()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let isUnitTesting = ProcessInfo.processInfo.environment["IS_UNIT_TESTING"] == "YES"
        
        guard !isUnitTesting, let windowScene = scene as? UIWindowScene else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = UIHostingController(rootView: appAssembly.container.resolve(TabbarView.self)!)
        self.window = window
        window.makeKeyAndVisible()
    }
}
