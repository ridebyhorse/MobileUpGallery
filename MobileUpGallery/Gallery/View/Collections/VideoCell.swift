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
    
    private let title: PaddingLabel = {
        let title = PaddingLabel(withInsets: 6, 6, 12, 12)
        title.textColor = .label
        title.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        title.layer.cornerRadius = 12
        title.font = .systemFont(ofSize: 13, weight: .medium)
        title.numberOfLines = 2
        title.textAlignment = .right
        title.clipsToBounds = true
        
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
        contentView.addSubview(title)
        contentView.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            previewView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            title.bottomAnchor.constraint(equalTo: previewView.bottomAnchor, constant: -16),
            title.trailingAnchor.constraint(equalTo: previewView.trailingAnchor, constant: -16),
            title.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.6)
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
