//
//  GalleryController.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 20.08.2024.
//

import UIKit
import VKID

final class GalleryController: UIViewController {
    private let presenter: GalleryPresenter
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    private let idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.font = .systemFont(ofSize: 10, weight: .regular)
        idLabel.textColor = .white
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return idLabel
    }()
    
    init(presenter: GalleryPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        presenter.activate()
        configure()
    }
    
    private func configure() {
        let stack = UIStackView(arrangedSubviews: [nameLabel, idLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 18
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension GalleryController: GalleryControllerProtocol {
    func update(with user: User?) {
        guard let user else { return }
        nameLabel.text = (user.firstName ?? "Имя") + " " + (user.lastName ?? "Фамилия")
        idLabel.text = String(user.id.value)
    }
}
