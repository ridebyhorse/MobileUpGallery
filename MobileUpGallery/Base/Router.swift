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
        do {
            try AuthenticationManager.shared.setup()
        }
        catch {
            print(error)
            showError(title: "Ощибка сервиса авторизации", message: "Попробуйте снова", actionTitle: "OK") { [weak self] _ in
                self?.start()
            }
        }
        
        if AuthenticationManager.shared.isLoggedIn {
            startGallery()
        } else {
            startLogin()
        }
    }
    
    func startLogin() {
        if let navigation = window.rootViewController as? UINavigationController {
            navigation.popToRootViewController(animated: true)
        } else {
            let login = builder.buildLogin()
            login.presenter.router = self
            window.rootViewController = UINavigationController(rootViewController: login)
            window.makeKeyAndVisible()
        }
    }
    
    func startGallery() {
        if let navigation = window.rootViewController as? UINavigationController {
            let gallery = builder.buildGallery()
            gallery.presenter.router = self
            navigation.pushViewController(gallery, animated: true)
        } else {
            let login = builder.buildLogin()
            login.presenter.router = self
            let gallery = builder.buildGallery()
            gallery.presenter.router = self
            let navigation = UINavigationController(rootViewController: login)
            navigation.pushViewController(gallery, animated: false)
            window.rootViewController = navigation
            window.makeKeyAndVisible()
        }
    }
    
    func push(_ vc: UIViewController) {
        guard let navigation = window.rootViewController as? UINavigationController else { return }
        navigation.pushViewController(vc, animated: true)
    }
}

extension RootRouter: ErrorPresenting {
    func showError(title: String, message: String?, actionTitle: String?, action: ((UIView) -> Void)?) {
        let errorVC = UIViewController()
        let errorView = ErrorView()
        errorView.title = title
        errorView.message = message
        errorView.actionTitle = actionTitle
        errorView.action = action
        errorVC.view = errorView
        window.rootViewController = errorVC
        window.makeKeyAndVisible()
    }
    
    func hideError() {
        
    }
}
