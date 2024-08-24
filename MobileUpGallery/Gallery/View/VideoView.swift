//
//  VideoView.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 24.08.2024.
//

import UIKit

protocol VideoViewProtocol: AnyObject {
    func didUpdateVideos()
    func insertVideos(at indexPaths: [IndexPath])
}

final class VideoView: UIView {
    private lazy var videoCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "videoCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.tag = 1
        
        return collectionView
    }()
    
    var videoCollection: UICollectionView {
        get { videoCollectionView }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(videoCollectionView)
        
        NSLayoutConstraint.activate([
            videoCollectionView.topAnchor.constraint(equalTo: topAnchor),
            videoCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            videoCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            videoCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
