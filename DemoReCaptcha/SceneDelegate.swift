//
//  SceneDelegate.swift
//  DemoReCaptcha
//
//  Created by Dmitrii Gordienko on 23.04.2024.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: ContentView())
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

