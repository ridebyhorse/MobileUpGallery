//
//  VideoCell.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 24.08.2024.
//

import UIKit

final class VideoCell: UICollectionViewCell {
    private let previewView: UIImageView = {
        let photoView = UIImageView()
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        
        return photoView
    }()
    
    private let titleBackground: UIView = {
        let titleBackground = UIView()
        titleBackground.backgroundColor = .systemBackground
        titleBackground.alpha = 0.5
        titleBackground.layer.cornerRadius = 16
        
        return titleBackground
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: 13, weight: .medium)
        title.numberOfLines = 2
        title.textAlignment = .right
        
        return title
    }()
  
    weak var delegate: VideoViewProtocol?
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
        previewView.image = nil
        title.text = nil
    }
    
    private func setupUI() {
        contentView.addSubview(previewView)
        contentView.addSubview(titleBackground)
        contentView.addSubview(title)
        contentView.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            previewView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            title.bottomAnchor.constraint(equalTo: previewView.bottomAnchor, constant: -28),
            title.trailingAnchor.constraint(equalTo: previewView.trailingAnchor, constant: -20),
            title.leadingAnchor.constraint(equalTo: previewView.leadingAnchor, constant: 140),
            titleBackground.topAnchor.constraint(equalTo: title.topAnchor, constant: -4),
            titleBackground.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            titleBackground.leadingAnchor.constraint(equalTo: title.leadingAnchor, constant: -12),
            titleBackground.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: 12)
        ])
    }
}

// MARK: - Configure Cell
extension VideoCell {
    func configure(with video: Video, and indexPath: IndexPath) {
        let url = video.image.first?.url
        previewView.kf.setImage(with: URL(string: url ?? ""))
        title.text = video.title
        self.indexPath = indexPath
    }
}
