//
//  GalleryController.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 20.08.2024.
//

import UIKit
import VKID

final class GalleryController: UIViewController {
    let presenter: GalleryPresenter
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    private let idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.font = .systemFont(ofSize: 10, weight: .regular)
        idLabel.textColor = .label
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return idLabel
    }()
    
    private let control: UISegmentedControl = {
        let control = UISegmentedControl()
        control.insertSegment(withTitle: "Фото", at: 0, animated: true)
        control.insertSegment(withTitle: "Видео", at: 1, animated: true)
        control.addTarget(self, action: #selector(tabSwitched), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        
        return control
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
        presenter.activate()
        title = "Mobile Up Gallery"
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        setupNavigationItem()
        control.selectedSegmentIndex = 0
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, idLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 18
        
        view.addSubview(control)
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            control.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            control.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            control.heightAnchor.constraint(equalToConstant: 32),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationItem() {
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(signOutTapped))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    @objc private func signOutTapped() {
        presenter.signOut()
    }
    
    @objc private func tabSwitched(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
}

extension GalleryController: GalleryControllerProtocol {
    func update(with user: User?) {
        guard let user else { return }
        nameLabel.text = (user.firstName ?? "Имя") + " " + (user.lastName ?? "Фамилия")
        idLabel.text = String(user.id.value)
    }
}
