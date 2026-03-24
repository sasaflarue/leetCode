//
//  SceneDelegate.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)

        // Choose your service
        let service: EventService = LocalEventService() // or RemoteEventService()

        let rootVC = EventListViewController(service: service)
        let nav = UINavigationController(rootViewController: rootVC)

        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
}
