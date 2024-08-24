//
//  PhotoDetailController.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 24.08.2024.
//

import UIKit

final class PhotoDetailController: UIViewController {
    private let photo: Photo
    
    private let photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        
        return photoView
    }()
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(photo.date)"
        setupNavigationItem()
        setupUI()
    }
    
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(sharePhoto))
        navigationController?.navigationBar.tintColor = .label
    }
    
    @objc private func sharePhoto() {
        guard let photo = photoView.image else { return }
        let ac = UIActivityViewController(activityItems: [photo], applicationActivities: nil)
        
        present(ac, animated: true)
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        let url = photo.sizes[photo.sizes.count - 1].url
        photoView.kf.setImage(with: URL(string: url))
        
        view.addSubview(photoView)
        view.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        NSLayoutConstraint.activate([
            photoView.widthAnchor.constraint(equalTo: view.widthAnchor),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor),
            photoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            photoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
