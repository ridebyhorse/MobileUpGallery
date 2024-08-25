//
//  ErrorView.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 25.08.2024.
//

import UIKit

protocol ErrorPresenting {
    func showError(
        title: String,
        message: String?,
        actionTitle: String?,
        action: ((UIView) -> Void)?
    )
    
    func hideError()
}

final class ErrorView: UIView {
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var message: String? {
        didSet {
            messageLabel.text = message
            messageLabel.isHidden = message == nil
        }
    }
    
    var actionTitle: String? {
        didSet {
            actionButton.setTitle(actionTitle, for: .normal)
        }
    }
    
    var action: ((UIView) -> Void)? {
        didSet {
            actionButton.isHidden = action == nil
        }
    }
    
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let actionButton = UIButton()
    private let errorStack = UIStackView()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        messageLabel.textColor = .label
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.alignment = .center
        textStack.spacing = 12
        
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(messageLabel)
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .label
        configuration.baseForegroundColor = .systemBackground
        configuration.titleAlignment = .center
        configuration.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        actionButton.configuration = configuration
        actionButton.layer.cornerRadius = 12
        actionButton.isHidden = true
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        
        errorStack.axis = .vertical
        errorStack.alignment = .center
        errorStack.spacing = 24
        errorStack.addArrangedSubview(textStack)
        errorStack.addArrangedSubview(actionButton)
        
        addSubview(errorStack)
        subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            errorStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            errorStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            errorStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    @objc
    private func didTapActionButton() {
        action?(self)
    }
}
