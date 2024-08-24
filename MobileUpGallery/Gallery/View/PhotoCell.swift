//
//  PhotoCell.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 22.08.2024.
//

import UIKit
import Kingfisher

final class PhotoCell: UICollectionViewCell {
    private let photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        
        return photoView
    }()
  
    weak var delegate: PhotoViewProtocol?
    var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
    }
    
    private func setupUI() {
        contentView.addSubview(photoView)
        contentView.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension PhotoCell {
    func configure(with photo: Photo, and indexPath: IndexPath) {
        let url = photo.sizes[photo.sizes.count - 1].url
        photoView.kf.setImage(with: URL(string: url))
        self.indexPath = indexPath
    }
}
