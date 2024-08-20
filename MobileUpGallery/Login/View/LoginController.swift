//
//  LoginController.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 19.08.2024.
//

import UIKit
import VKID

final class LoginController: UIViewController {
    let presenter: LoginPresenter
    var oneTap: OneTapButton?
    
    init(presenter: LoginPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.activate()
        view.backgroundColor = .green
    }
    
    private func configure(with button: UIView) {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension LoginController: LoginControllerProtocol {
    func setupAuth(vkid: VKID?, onAuth: ((AuthResult) -> Void)?) {
        oneTap = OneTapButton { authResult in
            onAuth?(authResult)
        }
        guard let vkid, let oneTap else { return }
        let oneTapView = vkid.ui(for: oneTap).uiView()
        configure(with: oneTapView)
    }
}
