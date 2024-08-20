//
//  Router.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 20.08.2024.
//

import UIKit

final class RootRouter {
    private let window: UIWindow
    private let builder: Builder

    init(_ window: UIWindow, builder: Builder) {
        self.window = window
        self.builder = builder
    }

    deinit {
        print("root died")
    }

    func start() {
//        if let currentSession = AuthenticationManager.shared.currentSession {
//            startGallery()
//        } else {
            startLogin()
//        }
    }

    func startLogin() {
        let login = builder.buildLogin()
        login.presenter.router = self
        window.rootViewController = login
        window.makeKeyAndVisible()
    }

    func startGallery() {
        let gallery = builder.buildGallery()
        window.rootViewController = gallery
        window.makeKeyAndVisible()
    }
    
    func showGallery() {
        let gallery = builder.buildGallery()
        window.rootViewController?.present(gallery, animated: true)
    }
}
