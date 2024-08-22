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
    private var oneTap: OneTapButton?
    private let mainLabel = UILabel()
    
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
        view.backgroundColor = .systemBackground
    }
    
    private func configure(with button: UIView) {
        mainLabel.font = .systemFont(ofSize: 44, weight: .bold)
        mainLabel.textColor = .label
        mainLabel.text = "Mobile Up\nGallery"
        mainLabel.numberOfLines = 0
        
        view.addSubview(mainLabel)
        view.addSubview(button)
        view.subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension LoginController: LoginControllerProtocol {
    func setupAuth(vkid: VKID?, onAuth: ((AuthResult) -> Void)?) {
        oneTap = OneTapButton(
            appearance: .init(
                style: .primary(),
                theme: .matchingColorScheme(.system)
            ),
            layout: .regular(
                height: .large(.h52),
                cornerRadius: 12
            ),
            presenter: .newUIWindow
        ) { authResult in
            onAuth?(authResult)
        }
        guard let vkid, let oneTap else { return }
        let oneTapView = vkid.ui(for: oneTap).uiView()
        configure(with: oneTapView)
    }
}
