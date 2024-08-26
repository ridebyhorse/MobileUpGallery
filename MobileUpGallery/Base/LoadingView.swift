//
//  LoadingView.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 25.08.2024.
//

import UIKit

protocol LoadingPresenting: AnyObject {
    func showLoading()
    func hideLoading()
}

class LoadingView: UIView {
    private let loadingImage = UIImageView()
    
    init() {
        super.init(frame: .zero)
        setupUI()
        playAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .systemBackground
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            loadingImage.image = .loadingLight
        } else {
            loadingImage.image = .loadingDark
        }
        
        addSubview(loadingImage)
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingImage.widthAnchor.constraint(equalToConstant: 120),
            loadingImage.heightAnchor.constraint(equalToConstant: 120),
            loadingImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func playAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .repeat) {[weak self] in
            self?.loadingImage.rotate()
        }
    }
    
}
