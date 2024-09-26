//
//  SceneDelegate.swift
//  Win-Football_News
//
//  Created by Александр Андреев on 26.09.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        start()
    }

    func start() {
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }


}

